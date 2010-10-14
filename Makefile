REBAR=./rebar

all: compile

compile:
	$(REBAR) get-deps compile

test: all
	$(REBAR) skip_deps=true eunit

clean:
	-rm -rf deps ebin priv doc/* ct_run* all_runs.html variables* index.html

docs:
	$(REBAR) doc

ifeq ($(wildcard sqlite3.plt),)
static:
	dialyzer --build_plt --output_plt sqlite3.plt --apps erts kernel stdlib crypto compiler hipe syntax_tools -r ebin
else
static:
	dialyzer --add_to_plt --plt sqlite3.plt -r ebin --get_warnings
endif