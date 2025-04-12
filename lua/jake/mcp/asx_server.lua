return {
    name = "asx",
    capabilities = {
        tools = {
            {
                name = "search_web",
                description = "Search the web for a given query",
                inputSchema = {
                    type = "object",
                    properties = {
                        query = {
                            type = "string",
                            description = "Search query",
                        },
                    },
                    required = { "query" },
                },
                handler = function(req, res)
                    -- Implement web search logic here
                    local query = req.params.query
                    -- Placeholder response
                    return res:text("Search results for: " .. query):send()
                end,
            },
            {
                name = "download_pdf",
                description = "Click and download a PDF from a given URL",
                inputSchema = {
                    type = "object",
                    properties = {
                        url = {
                            type = "string",
                            description = "URL of the PDF",
                        },
                    },
                    required = { "url" },
                },
                handler = function(req, res)
                    -- Implement PDF download logic here
                    local url = req.params.url
                    -- Placeholder response
                    return res:text("Downloaded PDF from: " .. url):send()
                end,
            },
            {
                name = "parse_rich_text",
                description = "Parse and read rich text from a given input",
                inputSchema = {
                    type = "object",
                    properties = {
                        text = {
                            type = "string",
                            description = "Rich text input",
                        },
                    },
                    required = { "text" },
                },
                handler = function(req, res)
                    -- Implement rich text parsing logic here
                    local text = req.params.text
                    -- Placeholder response
                    return res:text("Parsed text: " .. text):send()
                end,
            },
            {
                name = "draw_conclusions",
                description = "Draw conclusions from the parsed text",
                inputSchema = {
                    type = "object",
                    properties = {
                        parsed_text = {
                            type = "string",
                            description = "Parsed text input",
                        },
                    },
                    required = { "parsed_text" },
                },
                handler = function(req, res)
                    -- Implement conclusion drawing logic here
                    local parsed_text = req.params.parsed_text
                    -- Placeholder response
                    return res:text("Conclusions drawn from text: " .. parsed_text):send()
                end,
            },
        },
        resources = {
            {
                name = "asx_methodology",
                uri = "asx://methodology",
                description = "ASX methodology",
                handler = function(req, res)
                    -- Provide ASX methodology here
                    return res:text("ASX Methodology: ..."):send()
                end,
            },
            {
                name = "sample_constituent_data",
                uri = "asx://constituent_data",
                description = "Sample constituent data",
                handler = function(req, res)
                    -- Provide sample constituent data here
                    return res:text("Sample Constituent Data: ..."):send()
                end,
            },
        },
    },
}
