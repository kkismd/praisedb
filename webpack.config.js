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
    extensions: [".js", ".coffee"],
    alias: {
      'jquery-ui': 'jquery-ui/ui/widgets',
      'jquery-ui-css': 'jquery-ui/../../themes/base'
    }
  },
  module: {
    rules: [
      {
        test: /\.(css)$/,
        use: [MiniCssExtractPlugin.loader, 'css-loader']
      },
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
            loader: 'sass-loader'
          }
        ]
      },
      {
        test: /\.(png|jpg|gif|ttf|eot|woff|woff2|svg)$/,
        use: "file-loader"
      },
      {
        test: /\.coffee$/,
        use: ['coffee-loader']
      }
    ]
  },
  plugins: [
    new WebpackAssetsManifest({ publicPath: true }),
    new MiniCssExtractPlugin({
      filename: isProd ? "[name]-[hash].css" : "[name].css"
    })]
};
