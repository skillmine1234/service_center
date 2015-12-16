exit if ENV['SKIP_INIT'] == 'yes'

ENV['TZ'] = 'UTC'

ActiveSupport.on_load(:active_record) do
  if defined?ActiveRecord::ConnectionAdapters::OracleEnhancedAdapter
    ActiveRecord::ConnectionAdapters::OracleEnhancedAdapter.class_eval do
      self.emulate_integers_by_column_name = true
      self.emulate_dates_by_column_name = true
      self.string_to_date_format = "%d.%m.%Y"
      self.string_to_time_format = "%d.%m.%Y %H:%M:%S"
      def self.is_integer_column? (name, table_name = nil)
        name =~ /((^|_)id$|_cnt$)/i
      end
    end
  end
end


def use_decimal_for_number
  if defined?ActiveRecord::ConnectionAdapters::OracleEnhancedAdapter and ActiveRecord::Base.connection.instance_of?ActiveRecord::ConnectionAdapters::OracleEnhancedAdapter
    'NUMBER'
  else
    'decimal'
  end
end 

module ActiveRecord::ConnectionAdapters
 class TableDefinition
   def number (*args)
     options = args.extract_options!
     column_names = args
     column_names.each { |name| column(name, use_decimal_for_number, options) }
   end
 end
 class Table
   def number (*args)
     options = args.extract_options!
     column_names = args
     column_names.each { |name| column(name, use_decimal_for_number, options) }
   end
 end
end