const { environment } = require('@rails/webpacker');
const erb = require('./loaders/erb');

environment.config.externals = {
  gon: 'gon',
  routes: 'Routes',
};

environment.loaders.append('erb', erb);

module.exports = environment;
