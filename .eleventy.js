module.exports = function (eleventyConfig) {
  return {
    dir: {
      input: "src",
      output: "dist",
    },
    templateFormats: ["njk", "md"],
    markdownTemplateEngine: "njk",
  };
};
