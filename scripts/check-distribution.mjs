import { access, readFile } from 'node:fs/promises';
import { resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

const root = resolve(fileURLToPath(new URL('..', import.meta.url)));
const marketplaces = [
  '.agents/plugins/marketplace.json',
  '.claude-plugin/marketplace.json',
  '.cursor-plugin/marketplace.json',
];
for (const path of marketplaces) {
  const marketplace = JSON.parse(await readFile(resolve(root, path), 'utf8'));
  if (marketplace.name !== 'latentcolor' || !Array.isArray(marketplace.plugins)) {
    throw new Error(`${path} must declare the latentcolor marketplace.`);
  }
  for (const plugin of marketplace.plugins) {
    const pluginSource =
      typeof plugin.source === 'string'
        ? plugin.source
        : plugin.source?.source === 'local' && typeof plugin.source.path === 'string'
          ? plugin.source.path
          : null;
    if (plugin.name !== 'latentcolor' || !pluginSource) {
      throw new Error(`${path} has an invalid plugin entry.`);
    }
    const pluginPath = resolve(root, pluginSource.replace(/^\.\//, ''));
    await access(pluginPath);
  }
}
const shell = await readFile(resolve(root, 'install.sh'), 'utf8');
if (!shell.includes('releases/latest/download/version.txt')) {
  throw new Error('install.sh must resolve the current version before download.');
}
if (shell.includes('latentcolor-${os}-${arch}.tar.gz')) {
  throw new Error('install.sh must download only versioned archive names.');
}
const powershell = await readFile(resolve(root, 'install.ps1'), 'utf8');
if (!powershell.includes('releases/latest/download/version.txt')) {
  throw new Error('install.ps1 must resolve the current version before download.');
}
console.log('Marketplace metadata and installers are valid.');
