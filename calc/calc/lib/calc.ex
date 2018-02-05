defmodule Calc do
    def main() do
        case IO.gets("Enter expression to calculate \n") do
            {:error, reason} ->
                IO.puts "Error: #{reason}"
        
            str ->
                str
                    |> eval()
                    |> IO.puts()
                main()
        end
    end

    #String -> Number
    def eval(str) do
        try do
        str
            |> String.trim()
            |> separate_numbers()
            |> String.split()
            |> eval_list()
            catch
                x -> "Error: #{x}"
            end
    end
   
    #List -> Number 
    defp eval_list(li) do
        cond do
            Enum.find(li, fn(x) -> x == "(" end) ->
                parenIndexL = Enum.find_index(li, fn(x) -> x == "(" end)
                    parenIndexR = match_paren(parenIndexL, li)
                    leftlist = Enum.slice(li, 0..(parenIndexL - 1))
                    middleVal = eval_list(Enum.slice(li, (parenIndexL + 1)..(parenIndexR - 1)))
                    middlelist = List.insert_at([], 0, Integer.to_string(middleVal))
                    rightlist = Enum.slice(li, (parenIndexR + 1)..(Enum.count(li) - 1))
                    leftlist
                        |> Enum.concat(middlelist)
                        |> Enum.concat(rightlist)
                        |> eval_list()

            Enum.find(li, fn(x) -> x == "+" end) ->
                addIndex = Enum.find_index(li, fn(x) -> x == "+" end)
                leftlist = li
                            |> Enum.slice(0..addIndex - 1)
                            |> eval_list
                rightlist = li
                            |> Enum.slice((addIndex + 1)..(Enum.count(li) - 1))
                            |> eval_list
                leftlist + rightlist

            Enum.find(li, fn(x) -> x == "-" end) ->
                subIndex = Enum.find_index(li, fn(x) -> x == "-" end)
                leftlist = li
                            |> Enum.slice(0..subIndex - 1)
                            |> eval_list
                rightlist = li
                            |> Enum.slice((subIndex + 1)..(Enum.count(li) - 1))
                            |> eval_list
                leftlist - rightlist

            Enum.find(li, fn(x) -> x == "*" end) ->
                multIndex = Enum.find_index(li, fn(x) -> x == "*" end)
                leftlist = li
                            |> Enum.slice(0..multIndex - 1)
                            |> eval_list
                rightlist = li
                            |> Enum.slice((multIndex + 1)..(Enum.count(li) - 1))
                            |> eval_list
                leftlist * rightlist

            Enum.find(li, fn(x) -> x == "/" end) ->
                divIndex = Enum.find_index(li, fn(x) -> x == "/" end)
                leftlist = li
                            |> Enum.slice(0..divIndex - 1)
                            |> eval_list
                rightlist = li
                            |> Enum.slice((divIndex + 1)..(Enum.count(li) - 1))
                            |> eval_list
                leftlist / rightlist

            true ->
                try do
                li
                    |> List.first()
                    |> String.to_integer()
                catch
                    x -> "Error #{x}"
                end
        end
    end

    #Number List -> Number
    defp match_paren(parenIndex, li) do
        firstClose = Enum.find_index(li, fn(x) -> x == ")" end)
        lastClose = Enum.count(li) - Enum.find_index(Enum.reverse(li), fn(x) -> x == ")" end)
        cond do
            firstClose == lastClose -> 
                lastClose
            firstClose < parenIndex -> 
                error = "Error: No matching opening paren for closing paren" 
                throw(error)
                IO.puts(error)
            firstClose > parenIndex ->
                firstClose
            true ->
                error = "Error: No matching closing paren for opening paren"
                throw(error)
                IO.puts(error)
        end
    end

    #String -> String
    defp separate_numbers(str) do
        str
            |> String.replace("(", " ( ")
            |> String.replace(")", " ) ")
            |> String.replace("+", " + ")
            |> String.replace("-", " - ")
            |> String.replace("*", " * ")
            |> String.replace("/", " / ")
    end
end
