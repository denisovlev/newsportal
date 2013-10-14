ActiveAdmin.register_page "Dashboard" do

    menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

    content :title => "Statistics" do
        div "Users registered: " do
            strong User.count
        end
        div "Users registered today: " do
            strong User.today.count
        end
        div "Articles count: " do
            strong Article.count
        end
    end # content
end
