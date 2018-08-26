class Detail < ApplicationRecord
  include AASM
  attr_accessor :s_employee_id, :r_employee_id
  belongs_to :ticket
  belongs_to :stored_employee, class_name: 'Employee',
              foreign_key: 'stored_employee_id', optional: true
  belongs_to :retrieved_employee, class_name: 'Employee',
              foreign_key: 'retrieved_employee_id', optional: true
  default_scope -> { order(created_at: :desc) }
  validates :amount, presence: true, length: { maximum: 3 }, numericality: { only_integer: true }, on: [:create, :edit]
  validates :location, presence: true, length: { maximum: 20 }, on: [:create, :edit]
  validates :room, inclusion: { in: [501, 502, 503, 504, 505, 506, 507, 510, 512, 514, 515, 516, 517, 518, 519, 520, 522, 523, 525, 601, 602, 603, 604, 605, 606, 607, 610, 612, 614, 615, 616, 617, 618, 619, 620, 622, 623, 625, 701, 702, 703, 704, 705, 706, 707, 710, 712, 714, 715, 716, 717, 718, 719, 720, 722, 723, 725, 801, 802, 803, 804, 805, 806, 807, 810, 812, 814, 815, 816, 817, 818, 819, 820, 823, 901, 902, 903, 904, 905, 906, 907, 909, 910, 912, 914, 915, 916, 917, 918, 919, 920, 922, 923, 925, 1001, 1002, 1003, 1004, 1005, 1006, 1007, 1009, 1010, 1012, 1014, 1015, 1016, 1017, 1018, 1019, 1020, 1022, 1023, 1025, 1101, 1102, 1103, 1104, 1105, 1106, 1107, 1109, 1110, 1112, 1114, 1115, 1116, 1117, 1118, 1119, 1120, 1122, 1123, 1125, 1201, 1202, 1203, 1204, 1205, 1206, 1207, 1209, 1210, 1212, 1214, 1215, 1216, 1217, 1218, 1219, 1220, 1222, 1223, 1225, 1401, 1402, 1403, 1404, 1405, 1406, 1407, 1409, 1410, 1412, 1414, 1415, 1416, 1417, 1418, 1419, 1420, 1422, 1423, 1425, 1501, 1502, 1503, 1504, 1505, 1506, 1507, 1509, 1510, 1512, 1514, 1515, 1516, 1517, 1518, 1519, 1520, 1522, 1523, 1525, 1601, 1602, 1603, 1604, 1605, 1606, 1607, 1609, 1610, 1612, 1614, 1615, 1616, 1617, 1618, 1619, 1620, 1622, 1623, 1625, 1701, 1702, 1703, 1704, 1705, 1706, 1707, 1709, 1710, 1712, 1714, 1715, 1716, 1717, 1718, 1719, 1720, 1722, 1723, 1725, 1801, 1802, 1803, 1804, 1805, 1806, 1807, 1810, 1812, 1814, 1815, 1816, 1817, 1818, 1819, 1820, 1822, 1823, 1825, 1901, 1902, 1903, 1904, 1905, 1906, 1907, 1910, 1912, 1914, 1915, 1916, 1917, 1918, 1919, 1920, 1922, 1923, 1925, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2010, 2012, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2022, 2023, 2025, 2101, 2102, 2103, 2104, 2105, 2106, 2107, 2109, 2110, 2112, 2114, 2115, 2116, 2117, 2118, 2119, 2120, 2122, 2123, 2125, 2201, 2202, 2203, 2204, 2205, 2206, 2207, 2209, 2210, 2212, 2214, 2215, 2216, 2217, 2218, 2219, 2220, 2222, 2223, 2225, 2301, 2302, 2303, 2304, 2305, 2306, 2307, 2309, 2310, 2312, 2314, 2315, 2316, 2317, 2318, 2319, 2320, 2322, 2323, 2325, 2401, 2402, 2403, 2404, 2405, 2406, 2407, 2409, 2410, 2412, 2414, 2415, 2416, 2417, 2418, 2419, 2420, 2422, 2423, 2425, 2501, 2502, 2503, 2504, 2505, 2506, 2507, 2509, 2510, 2512, 2514, 2515, 2516, 2517, 2518, 2519, 2520, 2522, 2523, 2525, 2601, 2602, 2603, 2604, 2605, 2606, 2607, 2609, 2610, 2612, 2614, 2615, 2616, 2617, 2618, 2619, 2620, 2622, 2623, 2625, 2701, 2702, 2703, 2704, 2705, 2706, 2707, 2709, 2710, 2712, 2714, 2715, 2716, 2717, 2718, 2719, 2720, 2722, 2723, 2725, 2801, 2802, 2803, 2804, 2805, 2806, 2807, 2809, 2810, 2812, 2814, 2815, 2816, 2817, 2818, 2819, 2820, 2822, 2823, 2825, 3018, 3028, 3038, 3068, 3088, 3118, 3128, 3138, 3168, 3178, 3188, 3218, 3228, 3238, 3268, 3318, 3328, 3338, 3368, 3418, 3428, 3438, 3468, 3518, 3528, 3538, 3568, 3618, 3628, 3718, 3728, 3818] }, :allow_nil => true, on: [:create, :edit]
  validates :s_employee_id, inclusion:
          { in: Employee.where(active: true).pluck(:id_number).map!(&:to_s) }, on: [:create, :edit]
  validates :r_employee_id, inclusion:
          { in: Employee.where(active: true).pluck(:id_number).map!(&:to_s) }, on: :update
  before_save { self.location = location.upcase }
  before_save :store_employee
  before_update :store_employee
  before_update :retrieve_employee

  aasm do
    state :ST
    state :RNR
    state :LT

    event :st do
      transitions to: :ST
    end

    event :rnr do
      transitions to: :RNR
    end

    event :lt do
      transitions to: :LT
    end
  end



  private

    def store_employee
      return unless stored_employee_id.nil?
      if s_employee_id
        self.stored_employee = Employee.find_by_id_number(s_employee_id)
      end
    end

    def retrieve_employee
      return unless retrieved_employee_id.nil?
      if r_employee_id
        self.retrieved_employee = Employee.find_by_id_number(r_employee_id)
      end
    end
end
