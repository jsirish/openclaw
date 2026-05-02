const fs = require('fs');

const repoConfigPath = '/Users/jsirish/.openclaw/workspace/openclaw.json';
const activeConfigPath = '/Users/jsirish/.openclaw/openclaw.json';

const repoConfig = JSON.parse(fs.readFileSync(repoConfigPath, 'utf8'));
const activeConfig = JSON.parse(fs.readFileSync(activeConfigPath, 'utf8'));

activeConfig.agents.defaults.agentOverrides = repoConfig.agents.defaults.agentOverrides;

fs.writeFileSync(activeConfigPath, JSON.stringify(activeConfig, null, 2));
console.log('Successfully patched active config agentOverrides');
