defmodule Reshape.Convertcsv do
    import NimbleCSV

    NimbleCSV.define(NimbleCSV.Spreadsheet, [])
    NimbleCSV.define(CsvParser, separator: ",", escape: "\"")

    def run(data, meta) do
        headers = data
            |> extract_keys
            |> Enum.uniq

        contents = data
            |> map_to_list(headers)
        
        [headers]
            |> Enum.concat(contents)
            |> CsvParser.dump_to_iodata
            |> IO.iodata_to_binary
    end

    defp extract_keys([head | tail]) do
        if Enum.count(tail) != 0 do
            Map.keys(head) ++ extract_keys(tail)
        else
            Map.keys(head)
        end
    end

    defp map_to_list([head | tail], keys) do
        if Enum.count(tail) != 0 do
            [extract_values(head, keys)] ++ map_to_list(tail, keys)
        else
            [extract_values(head, keys)]
        end
    end

    defp extract_values(data, [head | tail]) do
        if Enum.count(tail) != 0 do
            [data[head]] ++ extract_values(data, tail)
        else
            [data[head]]
        end
    end
end