Select * from data_cleaning..NashvilleHousing

--------------------------------------------------------------------------------------

--Correct formatting of the Sales Date format
select SaleDate, CONVERT(date,SaleDate) as Sales_date
from data_cleaning..NashvilleHousing --Current Format

Alter Table NashvilleHousing 
Add SaleDateCorrected Date;

Update NashvilleHousing
SET SaleDateCorrected = CONVERT(DATE,SaleDate)

select SaleDateCorrected
from
data_cleaning..NashvilleHousing --Corrected format

--------------------------------------------------------------------------------------
--PropertyAddress column contains null values, let's deal with that

select PropertyAddress
from data_cleaning..NashvilleHousing
where PropertyAddress is NULL 

select *
from data_cleaning..NashvilleHousing
order by ParcelID

select *
from data_cleaning..NashvilleHousing
order by ParcelID


Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, 
ISNULL(a.PropertyAddress,b.PropertyAddress)
From data_cleaning.dbo.NashvilleHousing a
JOIN data_cleaning.dbo.NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] != b.[UniqueID ]
Where a.PropertyAddress is null

Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From data_cleaning.dbo.NashvilleHousing a
JOIN data_cleaning.dbo.NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

--------------------------------------------------------------------------------------

--Address is not in the correct format, let's place it into indiviual columns

select PropertyAddress
from 
data_cleaning..NashvilleHousing --Checking the format 

select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)) as Address
from data_cleaning..NashvilleHousing

select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1) as Address
from data_cleaning..NashvilleHousing --Getting rid of commas

select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1) as Address
from data_cleaning..NashvilleHousing 

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 ,
LEN(PropertyAddress)) as Address
From data_cleaning..NashvilleHousing 

ALTER TABLE NashvilleHousing
Add PropertySplitAddress Nvarchar(255);

Update NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress,
1, CHARINDEX(',', PropertyAddress) -1 )

ALTER TABLE NashvilleHousing
Add PropertySplitCity Nvarchar(255); --Adding new column

Update NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress,
CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))

Select *
From data_cleaning..NashvilleHousing

Select OwnerAddress
From data_cleaning..NashvilleHousing 

Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From data_cleaning..NashvilleHousing

ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)

ALTER TABLE NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)

ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

Select OwnerAddress
From data_cleaning..NashvilleHousing 

--------------------------------------------------------------------------------------

-- In the 'Sold as vacant' column, let's change 'Y' to Yes and 'N' to no

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From data_cleaning..NashvilleHousing
Group by SoldAsVacant
order by 2

Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From data_cleaning..NashvilleHousing

Update NashvilleHousing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END


--------------------------------------------------------------------------------------

-- Delete Unused Columns

Select *
From data_cleaning..NashvilleHousing


ALTER TABLE data_cleaning..NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate


Select *
From data_cleaning..NashvilleHousing
--------------------------------------------------------------------------------------