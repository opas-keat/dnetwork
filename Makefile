run:
	fvm flutter run -d chrome

run_web:
	fvm flutter run -d web-server --web-port 8888 --web-hostname 0.0.0.0

build_web:
	fvm flutter build web --pwa-strategy=none --release

deploy:
	firebase deploy --only hosting
