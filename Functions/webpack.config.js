const path = require('path');

const config = {
  target: 'node',
  // Each function will have its own bundle, similar to a multi-page application.
  entry: {
    data: path.join(__dirname, 'src/data/index.js'),
  },
  output: {
    filename: '[name]/index.js',
    path: path.join(__dirname, 'dist'),
    library: 'index',
    libraryTarget: 'commonjs',
  },
};

module.exports = config;
