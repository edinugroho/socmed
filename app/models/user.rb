class User
    attr_accessor :id, :username ,:email

    def valid?
        return false if @username.nil?
        return false if @email.nil?
        true
    end
end