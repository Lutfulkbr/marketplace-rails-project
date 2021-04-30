class User < ApplicationRecord
    has_secure_password
    
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
end



# want to give user admin attribute
# add a column in users table called admin, set the datatype to a boolean, set this to default false
# check to see if user is admin for all admin functionalities 
