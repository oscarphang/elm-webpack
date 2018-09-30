var path = require('path');

module.exports = {
    mode: 'development',
    entry: './js/app.js',

    output: {
        path: path.join(__dirname, "dist"),
        filename: 'index.js',
        publicPath: '/dist/'
    },

    resolve: {
        modules: [
            path.join(__dirname, "src"),
            "node_modules"
        ],
        extensions: ['.js', '.elm']
    },

    devServer: {
        contentBase: __dirname + "/public/",
        inline: true,
    },
    module: {
        rules: [{
                test: /\.html$/,
                exclude: /node_modules/,
                use: 'file-loader?name=[name].[ext]'
            },
            {
                test: /\.elm$/,
                exclude: [/elm-stuff/, /node_modules/],
                use: [{
                        loader: 'elm-hot-webpack-loader'
                    },
                    {
                        loader: 'elm-webpack-loader',
                        options: process.env.WEBPACK_MODE === 'production' ? {
                            optimize: true
                        } : {
                            debug: true
                        }
                    }
                ],

            }
        ]

    },

    devServer: {
        inline: true,
        stats: 'errors-only'
    },

};