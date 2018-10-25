wget -q https://github.com/crossbrowsertesting/cbt-tunnel-nodejs/releases/download/v0.9.7/cbt_tunnels-macos-x64
chmod u+x cbt_tunnels-macos-x64
nohup ./cbt_tunnels-macos-x64 --username ${bamboo.CBT_USERNAME} --authkey ${CBT_AUTHKEY} --kill killfile > /dev/null 2>&1 &
echo "Successfully started local connection. Running tests..."
sleep 10