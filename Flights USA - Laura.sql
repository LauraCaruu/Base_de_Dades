/* 1. Quantitat de registres de la taula de vols: 
 
2. Retard promig de sortida i arribada segons l’aeroport origen. 
 
3. Retard promig d’arribada dels vols, per mesos i segons l’aeroport origen. 
A més, volen que els resultat es mostrin de la següent forma: 
LAX, 2000, 01, retard 
LAX, 2000, 02, retard … 
LAX, 2000, 12, retard 
LAX, 2001, 01, retard … 
ONT, 2000, 01, retard 
ONT, 2000, 02, retard etc. 
 
 
4. Retard promig d’arribada dels vols, per mesos i segons l’aeroport origen 
(mateixa consulta que abans i amb el mateix ordre). Però a més, ara volen que en comptes 
del codi de l’aeroport es mostri el nom de la ciutat.
 Los Angeles, 2000, 01, retard 
 Los Angeles, 2000, 02, retard 
 
 
5. Les companyies amb més vols cancelats. A més, han d’estar ordenades de forma que les companyies 
amb més cancelacions apareguin les primeres. 
 
6. L’identificador dels 10 avions que més kilòmetres han recorregut fent vols comercials: 
 
7. Companyies amb el seu retard promig només d’aquelles les quals els seus vols arriben al seu destí 
amb un retràs promig major de 10 minuts. 
 
*/

-- 1. Number of flights --
SELECT COUNT(flightID) AS NumberOfFlights FROM flights;
/* Result: 1083 Flights */

-- 2. Average delay according to airports --
SELECT AVG(ArrDelay) AS AverageArrivalDeley FROM flights;
/* Arrival Result: '9.6223' */
SELECT AVG(DepDelay) AS AverageDepartureDeley FROM flights; 
/* Deley Result: '9.1939' */

-- 3. Average of arrival flights in month according the origin aeroport. ---
SELECT * FROM usairlineflights.flights;
SELECT Origin, colYear, colMonth, AVG(ArrDelay) AS Delay
FROM usairlineflights.flights
GROUP BY Origin, colyear, colMonth;
/* Result:
'AMA', '2000', '12', '7.8800'
'AUS', '2000', '12', '7.7542'
'BDL', '2000', '12', '6.9450'
'BHM', '2000', '12', '14.7317'
'BNA', '2000', '12', '11.4595'
'BOS', '2000', '12', '12.7692'  
*/

-- 4. Avereage of delays of flights per months acording they origin airport. Show the name of the city instead of the city code. --
SELECT usairports.city, flights.colYear, flights.colMonth, AVG(flights.ArrDelay) AS Delay
FROM usairlineflights.flights
INNER JOIN usairports ON flights.origin=usairports.IATA
GROUP BY usairports.city, flights.colyear, flights.colMonth;
/* Result:
'Amarillo', '2000', '12', '7.8800'
'Austin', '2000', '12', '7.7542'
'Windsor Locks', '2000', '12', '6.9450'
'Birmingham', '2000', '12', '14.7317'
'Nashville', '2000', '12', '11.4595'
'Boston', '2000', '12', '12.7692'
 */

-- 5. The air companies with more canceled flights. Ascendent ordered. --
SELECT Description, CarrierCode FROM carriers
ORDER BY CarrierCode DESC; 

-- 6. Identify 10 commercial flights that makes more km.-- 
SELECT * FROM usairlineflights.flights;
SELECT TailNum, Distance FROM usairlineflights.flights
ORDER BY Distance ASC
LIMIT 10;
/* Result: 
N643AA	190
N5EMAA	190
N632AA	190
N636AA	190
N631AA	190
N636AA	190
N5CGAA	190
N5CRAA	190
N5CWAA	190
N5BTAA	190 
 */

-- 7.  Average Delay Air Companies only of those who arrive to their destination an average greater than 10 min late.--

SELECT carriers.Description AS Aircompany, AVG(flights.ArrDelay) AS Delay 
FROM usairlineflights.flights
Left JOIN carriers ON flights.uniqueCarrier=carriers.CarrierCode
WHERE flights.ArrDelay>10
GROUP BY flights.uniqueCarrier
ORDER BY Aircompany, `Delay` ASC;

/* result 
'American Airlines Inc.', '48.8030'
'Delta Air Lines Inc.', '43.1429' */
