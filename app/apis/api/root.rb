# require 'grape'
module API
  class Root < Grape::API
    # http://localhost:3000/api/
    prefix 'api'
    format :json

    mount API::Ver1::Root

    # get do
    # end

  end
end
