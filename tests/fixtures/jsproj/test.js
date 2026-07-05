const assert = require('assert');
const { loadConfig, calc } = require('./utils');

assert.strictEqual(loadConfig('{"a":1}').a, 1, 'loadConfig parses valid JSON');
assert.strictEqual(loadConfig('not json'), null, 'loadConfig returns null on invalid JSON');
// pricing rule: orders of 3+ items get a 10% discount
assert.strictEqual(calc([{ price: 10 }, { price: 10 }, { price: 10 }]), 27, 'bulk discount applied');
console.log('all tests passed');
