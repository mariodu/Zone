module Zone
  class Demo
    def initialize
      create_admin :dvd, 'davidqhr@gmail.com', '123456'
    end

    def create_user(name, email, password)
      FactoryGirl.create(:user, name: name, email: email, password: password)
    end

    def create_admin(name, email, password)
      FactoryGirl.create(:user, name: name, email: email, password: password, admin: true)
    end
  end
end