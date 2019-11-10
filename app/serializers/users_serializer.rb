class UsersSerializer
    attr_accessor :users

    def initialize(users)
        @users = users
    end #/initialize

    def as_json(tmp=nil)
        @users.map do |user|
            UserSerializer.new(user).as_json(tmp)
        end
    end

end #/UsersSerializer