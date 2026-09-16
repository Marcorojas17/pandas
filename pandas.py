# ═══════════════════════════════════════════════════════════
# ▓ SCDR-001 · BRICS DATAFRAME
# ═══════════════════════════════════════════════════════════

import pandas as pd

brics_dict = {
    "country": ["Brazil", "Russia", "India", "China", "South Africa"],
    "capital": ["Brasilia", "Moscow", "New Delhi", "Beijing", "Pretoria"],
    "area":    [8.516, 17.10, 3.286, 9.597, 1.221]
}

brics = pd.DataFrame(brics_dict)
brics.index = ["BR", "RU", "IN", "CH", "SA"]

print(brics)