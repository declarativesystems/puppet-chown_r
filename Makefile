all: Gemfile.local
	bundle exec pdqtest all

fast: Gemfile.local
	bundle exec pdqtest fast

shell: Gemfile.local
	bundle exec pdqtest --keep-container acceptance

shellnopuppet: Gemfile.local
	bundle exec pdqtest shell

logical: Gemfile.local
	bundle exec pdqtest syntax
	bundle exec pdqtest rspec

bundle:
	# First install into PDK world to get hard to find gems
	pdk bundle install
	# Install into _normal world_ bundle
	bundle install
	# Don't tell PDK
	rm Gemfile.lock
	# Install into _PDK_ bundle - because we re-bundled
	pdk bundle install

Gemfile.local:
	echo "[🐌] Creating symlink and running pdk bundle..."
	ln -s Gemfile.project Gemfile.local
	make bundle



