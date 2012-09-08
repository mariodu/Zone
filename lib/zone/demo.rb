module Zone
  class Demo
    def initialize
      david = create_admin :dvd, 'davidqhr@gmail.com', '123456'
      FactoryGirl.create(:topic, fonder: david)
      FactoryGirl.create(:topic, fonder: david)
      FactoryGirl.create(:topic, fonder: david)
      FactoryGirl.create(:topic, fonder: david)
    end

    def create_user(name, email, password)
      FactoryGirl.create(:user, name: name, email: email, password: password)
    end

    def create_admin(name, email, password)
      FactoryGirl.create(:user, name: name, email: email, password: password, admin: true)
    end
  end
end