ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Info" do
          para "Welcome to Remittance App Admin."
        end
        panel "Session" do
          ul do
            li link_to("Logout", destroy_admin_user_session_path)
          end
        end
      end
    end
  end # content
end
