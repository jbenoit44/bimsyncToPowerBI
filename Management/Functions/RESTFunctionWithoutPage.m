let
Source = (relativePath as text, revisionId as text, token as text) => let
	
		url = "https://api.bimsync.com",

		GetJson = Web.Contents
		(
			url,
			[
				Headers = 
				[
					#"Authorization"="Bearer " & token,
					#"Content-Type"="application/json"
				],
				Query = 
				[
					revision = revisionId
				],
				RelativePath = relativePath,
				ManualStatusHandling={500}
			]
		),
		GetMetadata = Value.Metadata(GetJson),
		GetResponseStatus = GetMetadata[Response.Status],
		ResultJsontext = if GetResponseStatus=500 then "[]" else Text.FromBinary(GetJson),
		Source = Json.Document(ResultJsontext )
in
Source
in
    Source