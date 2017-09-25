module DashboardHelper
  def build_menu(gem_name)
    engine = "Qg::#{gem_name.capitalize}".constantize

    if @current_user.group_names.include?(engine.const_get('GROUP'))
      m = {name: engine.const_get('NAME'), group: engine.const_get('GROUP'), items: []}
      
      if ENV['CONFIG_ENVIRONMENT'] == 'test'
        items = engine.const_get('MENU_ITEMS') + engine.const_get('TEST_MENU_ITEMS')
      else
        items = engine.const_get('MENU_ITEMS')
      end
      
      items.each do |i|
        m[:items] << {name: (I18n.t "menu.#{i}"), link_to: polymorphic_url(i.to_s.pluralize.classify.constantize), image_tag: "#{i}.png", size: '80x80'}
      end

      return m
    end
    
    nil
  end
end