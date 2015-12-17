-module(twitter_sample).

-export([user_timeline/0,
         tweet/1]).

-define(TIMELINE_URL, "https://api.twitter.com/1.1/statuses/user_timeline.json").
-define(STATUS_URL, "https://api.twitter.com/1.1/statuses/update.json").

user_timeline() ->
    {ok, Response} = oauth:get(?TIMELINE_URL,
                               [{"screen_name", oauth_param(screen_name)}],
                               consumer(),
                               oauth_param(access_token),
                               oauth_param(access_token_secret)),
    {{_, _, _}, _, Body} = Response,
    jsx:decode(list_to_binary(Body)).

tweet(Tweet) ->
    {ok, _} = oauth:post(?STATUS_URL,
                         [{"status", Tweet}],
                         consumer(),
                         oauth_param(access_token),
                         oauth_param(access_token_secret)).


consumer() ->
    {oauth_param(consumer_key), oauth_param(consumer_secret), hmac_sha1}.

oauth_param(Key) ->
    application:get_env(twitter_sample, Key, not_found).
        




