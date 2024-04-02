start:
	@echo "⚡️ Starting Minecraft server"
	java -Xmx1024M -Xms1024M -jar minecraft_server.jar nogui &

	@echo "⚡️ Starting ngrok"
	@ngrok tcp 25565 > /dev/null &

	@echo "⏳ Waiting for ngrok to be available"
	@while ! curl -s http://localhost:4040/api/tunnels >/dev/null; do \
		echo "Waiting for ngrok..."; \
		sleep 2; \
	done

	@echo "🔍 Retrieving ngrok remote URL"
	@NGROK_REMOTE_URL=$$(curl -s http://localhost:4040/api/tunnels | jq -r '.tunnels[0].public_url'); \
	if [ -z "$$NGROK_REMOTE_URL" ]; then \
		echo "❌ ERROR: ngrok doesn't seem to return a valid URL ($$NGROK_REMOTE_URL)"; \
		exit 1; \
	fi && \
	echo "✅ Ngrok remote URL: $$NGROK_REMOTE_URL" && \
	python ./sendtext.py "$$NGROK_REMOTE_URL"

	@while ! grep -q "For help" ./logs/latest.log; do \
		sleep 2; \
	done
	@echo ""

stop:
	@echo "Stopping Minecraft server"
	@PID=$$(ps -ef | grep 'minecraft_server.jar' | grep -v 'grep' | awk '{print $$2}'); \
	if [ -n "$$PID" ]; then \
		kill $$PID; \
		echo "Minecraft server stopped"; \
	else \
		echo "No Minecraft server process found"; \
	fi

	@echo "Stopping background ngrok process"
	@PID=$$(ps -ef | grep 'ngrok' | grep -v 'grep' | awk '{print $$2}'); \
	if [ -n "$$PID" ]; then \
		kill -9 $$PID; \
		echo "ngrok stopped"; \
	else \
		echo "No ngrok process found"; \
	fi
