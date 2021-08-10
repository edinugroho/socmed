class User
    def valid?
        return false if @username.nil?
        return false if @email.nil?
        true
    end
end