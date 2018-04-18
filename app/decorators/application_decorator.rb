class ApplicationDecorator < Draper::Decorator
  def self.collection_decorator_class
    PaginatingDecorator
  end

  def created_by
    object.created_user.try(:name)
  end

  def created_at
    object.created_at.strftime("%d/%m/%Y %I:%M%p")
  end

  def updated_by
    object.updated_user.try(:name)
  end

  def updated_at
    object.created_at.strftime("%d/%m/%Y %I:%M%p")
  end

  def req_timestamp
    object.req_timestamp.strftime("%d/%m/%Y %I:%M%p")
  end

  def rep_timestamp
    object.rep_timestamp.try(:strftime, "%d/%m/%Y %I:%M%p")
  end

  def response_time
    ((object.rep_timestamp - object.req_timestamp) * 1.days) rescue '0'
  end

  def audits
    h.link_to "show", :controller => "#{object.class.name.underscore.split('/').last.pluralize.to_sym}", :action => :audited_changes, :id => object.id
  end

  def active
    object.active ? "enabled" : "disabled"
  end

  def user_action
    h.capture do
      h.concat h.link_to h.fa_icon_tag("eye"), object, rel: 'tooltip', title: 'Show'
      h.concat " "
      h.concat h.link_to h.fa_icon_tag("pencil"), "#{object.class.name.underscore.pluralize}/#{object.id}/edit", rel: 'tooltip', title: 'Edit' if h.policy(object).edit?
    end
  end

  def audit_count
    count = object.audits.count
    count > 0 ? count - 1 : 0
  end
end
