/*                                 ADVANTAGE 360 KEY MATRIX / LAYOUT MAPPING
 ╭────────────────────────────┬────────────────────────────╮ ╭────────────────────────────┬────────────────────────────╮
 │  0   1   2   3   4   5   6 │  7   8   9  10  11  12  13 │ │ LN5 LN4 LN3 LN2 LN1 LN0 -- │ --  RN0 RN1 RN2 RN3 RN4 RN5│
 │ 14  15  16  17  18  19  20 │ 21  22  23  24  25  26  27 │ │ LT5 LT4 LT3 LT2 LT1 LT0 -- │ --  RT0 RT1 RT2 RT3 RT4 RT5│
 │ 28  29  30  31  32  33     │     34  35  36  37  38  39 │ │ LM5 LM4 LM3 LM2 LM1 LM0    │     RM0 RM1 RM2 RM3 RM4 RM5│
 │ 40  41  42  43  44  45  46 │ 47  48  49  50  51  52  53 │ │ LB5 LB4 LB3 LB2 LB1 LB0 -- │ --  RB0 RB1 RB2 RB3 RB4 RB5│
 │ 54  55  56  57  58╭────────┴────────╮59  60  61  62  63 │ │ --  --  --  --  LH0╭───────┴────────╮RH0 --  --  --  -- │
 ╰───────────────────┼────────┬────────┼───────────────────╯ ╰────────────────────┼───────┬────────┼───────────────────╯
                 ╭───╯ 64  65 │ 66  67 ╰───╮                                 ╭────╯ -- -- │ --  -- ╰───╮
                 │ 68  69  70 │ 71  72  73 │                                 │ LH1 LH0 -- │ --  RH2 RH1│
                 ╰───────╮ 74 │ 75 ╭───────╯                                 ╰───────╮ -- │ -- ╭───────╯
                         ╰────┴────╯                                                 ╰────┴────╯ */

#pragma once

#define LN0  5  // left-number row
#define LN1  4
#define LN2  3
#define LN3  2
#define LN4  1
#define LN5  0

#define RN0  8  // right-number row
#define RN1  9
#define RN2 10
#define RN3 11
#define RN4 12
#define RN5 13

#define LT0 19  // left-top row
#define LT1 18
#define LT2 17
#define LT3 16
#define LT4 15
#define LT5 14

#define RT0 22  // right-top row
#define RT1 23
#define RT2 24
#define RT3 25
#define RT4 26
#define RT5 27

#define LM0 33  // left-middle row
#define LM1 32
#define LM2 31
#define LM3 30
#define LM4 29
#define LM5 28

#define RM0 34  // right-middle row
#define RM1 35
#define RM2 36
#define RM3 37
#define RM4 38
#define RM5 39

#define LB0 45  // left-bottom row
#define LB1 44
#define LB2 43
#define LB3 42
#define LB4 41
#define LB5 40

#define RB0 48  // right-bottom row
#define RB1 49
#define RB2 50
#define RB3 51
#define RB4 52
#define RB5 53

#define LH0 58  // left thumb keys
#define LH1 68
#define LH2 69

#define RH0 59  // right thumb keys
#define RH1 73
#define RH2 72

