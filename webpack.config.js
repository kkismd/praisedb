const path = require("path");
const webpack = require('webpack');
const WebpackAssetsManifest = require("webpack-assets-manifest");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");

const { NODE_ENV } = process.env;
const isProd = NODE_ENV === "production";

module.exports = {
  mode: isProd ? "production" : "development",
  devtool: "source-map",
  entry: {
    application: path.resolve(__dirname, "app/javascript/application.js")
  },
  output: {
    path: path.resolve(__dirname, "public/packs"),
    publicPath: "/packs/",
    filename: isProd ? "[name]-[hash].js" : "[name].js"
  },
  resolve: {
    //extensions: [".js", ".scss"]
    extensions: [".js"]
  },
  module: {
    rules: [
      {
        test: /\.(scss)$/,
        use: [
          {
            loader: MiniCssExtractPlugin.loader,
            options: {}
          },
          {
            loader: 'css-loader',
            options: { sourceMap: true, importLoaders: 2  /*postcss+sass*/ }
          },
          {
            loader: 'postcss-loader',
            options: { sourceMap: true, plugins: [require('autoprefixer')] }
          },
          {
            loader: 'sass-loader',
            options: { sourceMap: true, outputStyle: 'expanded' }
          }
        ]
      }
    ]
  },
  plugins: [
    new WebpackAssetsManifest({ publicPath: true }),
    new MiniCssExtractPlugin({
      filename: isProd ? "[name]-[hash].css" : "[name].css"
    })]
};
