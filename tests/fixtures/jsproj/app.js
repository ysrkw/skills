const { calc, sumRange } = require('./utils');

const items = [{ price: 3 }, { price: 4 }];
console.log('total:', calc(items));
console.log('range:', sumRange(1, 3));
