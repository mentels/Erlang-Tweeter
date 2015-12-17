.PHONY: shell

shell:
	erl -pa _build/default/lib/*/ebin -config config/sys 

rebar:
	wget -c https://s3.amazonaws.com/rebar3/rebar3
	chmod +x rebar3
