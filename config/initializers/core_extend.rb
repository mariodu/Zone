class ActiveRecord::Base
  def model_type
    self.class.to_s.underscore.to_sym
  end
end