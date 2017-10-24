class Searcher
  include ActiveModel::Model
  include ActiveModel::Validations
  extend SimpleEnum::Attribute

  attr_accessor :has_full_access
  
  
  def self.attr_searchable(*vars)
    @attributes ||= []
    vars |= [:page, :approval_status]
    @attributes.concat vars

    attr_accessor(*vars)
  end

  PER_PAGE = 10

  def initialize(attributes = {})
    (attributes.to_h).each do |name, value|
      send("#{name}=", value)
    end
  end

  def export
    find
  end

  def persisted?
    false
  end      

  def klass
    self.class.name.chomp('Searcher').constantize
  end
  
  # the policy class is the same as that of the model
   def self.policy_class
     "#{name.chomp('Searcher')}Policy".constantize
   end
  
  def paginate
    if valid?
      _find.paginate(page: page,  :per_page => PER_PAGE)
    else
      klass.none.paginate(page: page,  :per_page => PER_PAGE)
    end
  end

  def _find
    if self.try(:approval_status).present? && approval_status == 'U'
      reln = klass.unscoped.where("approval_status = ?", approval_status).order("#{klass.table_name}.id desc")
    else
      reln = klass.order("#{klass.table_name}.id desc")
    end
    attrs.each do |a|
      reln = reln.where("#{klass.table_name}.#{a} = ?", self.try(a)) unless [nil, ''].include?(self.try(a))
    end

    # call the find for custom finder code implemented in subclasses
    find.nil? ? reln : reln.merge(find)
  end

  private

  def attrs
    # not all attributes are present in the model
    a = attributes.map &:to_s
    a - (a - klass.column_names) - ["approval_status"]
  end

  # returns true if any 1 searachable attribute has a value
  def searching?
    attrs.each do |a|
      return true unless [nil, ''].include?(self.try(a))
    end
    false
  end

  def self.attributes
    @attributes
  end

  def attributes
    self.class.attributes
  end

  def find
    nil
  end
end
