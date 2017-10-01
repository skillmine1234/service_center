module DashboardHelper
  def build_menu(gem_name)
    engine = "Qg::#{gem_name.capitalize}".constantize

    if @current_user.group_names.include?(engine.const_get('GROUP'))
      m = {name: engine.const_get('NAME'), group: engine.const_get('GROUP'), items: []}
      
      #to support rule setup screen, like EcolRule
      rule = engine.const_get('RULE') rescue nil
      unless rule.nil?
        unless rule.to_s.pluralize.classify.constantize.first.nil?
          m[:items] << {name: (I18n.t "menu.#{rule}"), link_to: polymorphic_url(rule.to_s.pluralize.classify.constantize.first), image_tag: "#{gem_name}/#{rule}.png", size: '80x80'}
        else
          m[:items] << {name: (I18n.t "menu.#{rule}"), link_to: error_msg_path, image_tag: "#{gem_name}/#{rule}.png", size: '80x80'}
        end
      end
      
      #to support screens needed for testing purpose, like QgEcolTodaysNeftTxn
      if ENV['CONFIG_ENVIRONMENT'] == 'test'
        items = engine.const_get('MENU_ITEMS') + engine.const_get('TEST_MENU_ITEMS')
      else
        items = engine.const_get('MENU_ITEMS')
      end
      
      items.each do |i|
        m[:items] << {name: (I18n.t "menu.#{i}"), link_to: polymorphic_url(i.to_s.pluralize.classify.constantize), image_tag: "#{gem_name}/#{i}.png", size: '80x80'}
      end
      
      #to support common screens, like IncomingFile
      m[:common_items] = engine.const_get('COMMON_MENU_ITEMS') rescue []

      return m
    end
    
    nil
  end
end