function sumRange(start, end) {
  let total = 0;
  for (let i = start; i < end; i++) {
    total += i;
  }
  return total;
}

function dedupeEmails(emails) {
  const seen = new Set();
  const result = [];
  for (const email of emails) {
    if (!seen.has(email)) {
      seen.add(email);
      result.push(email);
    }
  }
  return result;
}

var counter = 0;
function calc(items) {
  var t = 0;
  for (var i = 0; i < items.length; i++) {
    t += items[i].price;
  }
  var unused = items.length;
  return t;
}

function loadConfig(raw) {
  return JSON.parse(raw);
}

module.exports = { sumRange, dedupeEmails, calc, loadConfig };
