import csv

def main():
    with open("tees.csv") as f:
        tees_reader = csv.reader(f, delimiter=",")
        count = 0
        petzoo_url = "https://pet.zoocoin.cash/token/community/"
        ps_url = "https://paintswap.finance/marketplace/assets/0x903efda32f6d85ae074c1948c8d6b54f2421949f/" 
        for i in range(4):
            next(tees_reader)
        for row in tees_reader:
            if row[10] and int(row[0]) not in [14, 15, 17, 18, 19, 44]:
            # if row[10] and int(row[0]):
                # print(f"{count:2}: oldToNewId[{row[10]}] = {row[0]}")
                print(f"({count:2}) | {row[10]:4} | {row[0]:2} | {row[8]}")
                # print(f"{row[10]}")
                # print(f"({count:2}) | {petzoo_url}{row[10]:4} | {ps_url}{row[0]:2}")
                # print(f"oldToNewId[{row[10]}] = {row[0]}")
                count += 1

if __name__ == "__main__":
    main()
