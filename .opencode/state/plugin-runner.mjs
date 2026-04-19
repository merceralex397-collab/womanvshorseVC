import { pathToFileURL } from "node:url"
const pluginPath = process.env.SCAFFORGE_PLUGIN_PATH
if (!pluginPath) throw new Error('Missing SCAFFORGE_PLUGIN_PATH')
const mod = await import(pathToFileURL(pluginPath).href)
const factory = mod.StageGateEnforcer
if (typeof factory !== 'function') throw new Error('Missing StageGateEnforcer export')
const hooks = await factory()
const hook = hooks["tool.execute.before"]
if (typeof hook !== 'function') throw new Error('Missing tool.execute.before hook')
const toolName = process.env.SCAFFORGE_PLUGIN_TOOL
const rawArgs = process.env.SCAFFORGE_PLUGIN_ARGS || '{}'
const agent = process.env.SCAFFORGE_PLUGIN_AGENT || undefined
const sessionID = process.env.SCAFFORGE_PLUGIN_SESSION_ID || undefined
await hook({ tool: toolName, agent, sessionID }, { args: JSON.parse(rawArgs) })
console.log(JSON.stringify({ ok: true }))
