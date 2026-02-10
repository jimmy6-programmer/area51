path = r'D:\Area-51-Delivery\area_51_delivery\lib\screens\profile\favorites_screen.dart'
with open(path, 'r', encoding='utf-8') as f:
    s = f.read()

pairs = {'(': ')', '[': ']', '{': '}'}
openers = list(pairs.keys())
closers = list(pairs.values())
stack = []
for i, ch in enumerate(s):
    if ch in openers:
        stack.append((ch, i))
    elif ch in closers:
        if not stack:
            print('Unmatched closer', ch, 'at', i)
            break
        last, pos = stack.pop()
        if pairs[last] != ch:
            print('Mismatch at', i, 'expected', pairs[last], 'got', ch)
            break
else:
    if stack:
        last, pos = stack[-1]
        print('Unclosed opener', last, 'at', pos)
    else:
        print('All balanced')
