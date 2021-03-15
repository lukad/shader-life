function love.conf(t)
    t.window.title = "Shader Life"
    t.window.resizable = false
    t.releases = {
        title = "Shader Life",
        package = "shader-life",
        loveVersion = "11.3",
        version = "dev",
        author = "Luka Dornhecker",
        email = "luka.dornhecker@hey.com",
        description = "Conway's Game of Life",
        homepage = "https://github.com/lukad/shader-life",
        identifier = "me.dornhecker.shader-life",
        excludeFileList = {
            "README.md",
            ".DS_Store",
            ".editorconfig",
            ".vscode",
            "lib/hump/docs",
            "lib/hump/spec",
            "lib/hump/tests",
            ".travis.yml"
        },
        compile = true
    }
end
