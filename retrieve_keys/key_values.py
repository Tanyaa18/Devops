# 
'''
python3 getKeys.py "{\"a\": {\"b\": {\"c\": \"d\"}}}"
------------- OUTPUT ---------
Parsed json: {'a': {'b': {'c': 'd'}}}
Keys: ['a', 'b', 'c']
Values: ['d']
'''
import json
import sys
jsonString = '{"a":{"b":{"c":"d"}}, "x": 1}'
if len(sys.argv) > 1:
    jsonString = sys.argv[1]
else:
    print("No args provided, using an example json string")

jsonParsed: dict = json.loads(jsonString)
print("Parsed json:", jsonParsed)
values = []
index = -1

def getKeysAndValues(dictionary):
    if isinstance(dictionary, dict):
        keys = list(dictionary.keys())
        values = getValues(dictionary)
        if len(keys) > 0:
            childResult = [getKeysAndValues(dictionary[x]) for x in keys]
            for i in childResult:
                if i != None:
                    keys.extend(i[0])
                    values.extend(i[1])
        return [keys, values]

def getValues(dictionary: dict):
    values = list(dictionary.values())
    values = list(filter(lambda x: not isinstance(x, dict), values))
    return values

keysAndValues = getKeysAndValues(jsonParsed)
print("Keys:", keysAndValues[0])
print("Values:", keysAndValues[1])