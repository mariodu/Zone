module Zone
  class Demo
    def initialize
      david = create_admin :dvd, 'davidqhr@gmail.com', '123456'
      @topic_1 = FactoryGirl.create(:topic, fonder: david)
      @topic_2 = FactoryGirl.create(:topic, fonder: david)
      @topic_3 = FactoryGirl.create(:topic, fonder: david)

      FactoryGirl.create(:reply, topic: @topic_1, user: david)
      FactoryGirl.create(:reply, topic: @topic_1, user: david)
      FactoryGirl.create(:reply, topic: @topic_1, user: david)

      FactoryGirl.create(:reply, topic: @topic_2, user: david)
      FactoryGirl.create(:reply, topic: @topic_2, user: david)
      FactoryGirl.create(:reply, topic: @topic_2, user: david)

      FactoryGirl.create(:reply, topic: @topic_3, user: david)
      FactoryGirl.create(:reply, topic: @topic_3, user: david)
      FactoryGirl.create(:reply, topic: @topic_3, user: david)
    end

    def create_user(name, email, password)
      FactoryGirl.create(:user, name: name, email: email, password: password, complete_info: true)
    end

    def create_admin(name, email, password)
      FactoryGirl.create(:user, name: name, email: email, password: password, admin: true, complete_info: true)
    end
  end
end