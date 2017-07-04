package main

const tpl = `#### Bitdefender
{{- with .Results }}
| Infected      | Result      | Engine      | Updated      |
|:-------------:|:-----------:|:-----------:|:------------:|
| {{.Infected}} | {{.Result}} | {{.Engine}} | {{.Updated}} |
{{ end -}}
`

// func printMarkDownTable(bitdefender Bitdefender) {
//
// 	fmt.Println("#### Bitdefender")
// 	table := clitable.New([]string{"Infected", "Result", "Engine", "Updated"})
// 	table.AddRow(map[string]interface{}{
// 		"Infected": bitdefender.Results.Infected,
// 		"Result":   bitdefender.Results.Result,
// 		"Engine":   bitdefender.Results.Engine,
// 		"Updated":  bitdefender.Results.Updated,
// 	})
// 	table.Markdown = true
// 	table.Print()
// }
