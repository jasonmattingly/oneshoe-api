class TestController < ApplicationController
    def test
        payload = {"user_id": 42}
        token = TokenAuthorizationService.encode_token_from_payload(payload)
        render :json => JWT.decode(token, 'secret', true, algorithm: 'HS256')
    end
end
