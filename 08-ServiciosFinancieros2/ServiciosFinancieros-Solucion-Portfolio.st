!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Solucion-Portfolio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:09:32'!
test01PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio hasAccount: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:09:38'!
test02PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio hasAccount: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:09:45'!
test03PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio hasAccount: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:09:51'!
test04ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio hasAccounts ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:09:57'!
test05ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio hasAccounts ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:10:03'!
test06PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify hasAccounts ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:10:16'!
test07BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:57:31'!
test08BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:57:37'!
test09BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:57:42'!
test10PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:57:46'!
test11PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:57:51'!
test12PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Solucion-Portfolio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:01:58'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:56:59'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:57:06'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:57:10'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:57:15'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:57:20'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !


!classDefinition: #ReportsTest category: 'ServiciosFinancieros-Solucion-Portfolio'!
TestCase subclass: #ReportsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!ReportsTest methodsFor: 'tests' stamp: 'MS 12/14/2020 19:44:34'!
test01AccountSummaryOfAnAccountWithoutTransactionsIsZero

	| account accountSummary |
	
	account := ReceptiveAccount new.
	accountSummary := AccountSummary for: account.
	accountSummary := accountSummary generateReport.
	
	self assert: accountSummary size equals: 1.
	self assert: (accountSummary at: 1) equals: 'Balance = 0 pesos'.! !

!ReportsTest methodsFor: 'tests' stamp: 'MS 12/14/2020 19:44:44'!
test02AccountSummaryOfAnAccountWithADepositIsValid

	| account accountSummary |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	accountSummary := AccountSummary for: account.
	accountSummary := accountSummary generateReport.
		
	self assert: accountSummary size equals: 2.
	self assert: (accountSummary at: 1) equals: 'Depósito por 100 pesos'.
	self assert: (accountSummary at: 2) equals: 'Balance = 100 pesos'.! !

!ReportsTest methodsFor: 'tests' stamp: 'MS 12/14/2020 19:44:57'!
test03AccountSummaryOfAnAccountWithADepositAndWithdrawIsValid

	| account accountSummary |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 20 * peso on: account.
	accountSummary := AccountSummary for: account.
	accountSummary := accountSummary generateReport.
		
	self assert: accountSummary size equals: 3.
	self assert: (accountSummary at: 1) equals: 'Depósito por 100 pesos'.
	self assert: (accountSummary at: 2) equals: 'Extracción por 20 pesos'.
	self assert: (accountSummary at: 3) equals: 'Balance = 80 pesos'.! !

!ReportsTest methodsFor: 'tests' stamp: 'MS 12/14/2020 19:45:26'!
test04AccountSummaryOfAnAccountWithADepositAndTransferWithdrawIsValid

	| account1 account2 accountSummary |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 100 * peso on: account1.
	Transfer amount: 20 * peso from: account1 to: account2.
	accountSummary := AccountSummary for: account1.
	accountSummary := accountSummary generateReport.
		
	self assert: accountSummary size equals: 3.
	self assert: (accountSummary at: 1) equals: 'Depósito por 100 pesos'.
	self assert: (accountSummary at: 2) equals: 'Salida por transferencia de 20 pesos'.
	self assert: (accountSummary at: 3) equals: 'Balance = 80 pesos'.! !

!ReportsTest methodsFor: 'tests' stamp: 'MS 12/14/2020 19:45:41'!
test05AccountSummaryOfAnAccountWithATransferDepositIsValid

	| account1 account2 accountSummary |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 100 * peso on: account1.
	Transfer amount: 20 * peso from: account1 to: account2.
	accountSummary := AccountSummary for: account2.
	accountSummary := accountSummary generateReport.
		
	self assert: accountSummary size equals: 2.
	self assert: (accountSummary at: 1) equals: 'Entrada por transferencia de 20 pesos'.
	self assert: (accountSummary at: 2) equals: 'Balance = 20 pesos'.! !

!ReportsTest methodsFor: 'tests' stamp: 'MS 12/14/2020 19:49:43'!
test06AccountSummaryOfAPortfolioWithoutTransactionsIsZero

	| account portfolio portfolioSummary |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: account.
		
	portfolioSummary := AccountSummary for: portfolio.
	portfolioSummary := portfolioSummary generateReport.
		
	self assert: portfolioSummary size equals: 1.
	self assert: (portfolioSummary  at: 1) equals: 'Balance = 0 pesos'.! !

!ReportsTest methodsFor: 'tests' stamp: 'MS 12/14/2020 19:50:00'!
test07AccountSummaryOfAPortfolioWithTransactionsIsValid

	| account1 account2 portfolio1 portfolio2 portfolioSummary |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	portfolio1 add: account1.
	portfolio2 add: account2.
	portfolio1 add: portfolio2.
	
	Deposit register: 20*peso on: account1.
	Deposit register: 80*peso on: account2.
		
	portfolioSummary := AccountSummary for: portfolio1.
	portfolioSummary := portfolioSummary generateReport.
	
	self assert: portfolioSummary size equals: 3.
	self assert: (portfolioSummary at: 1) equals: 'Depósito por 20 pesos'.
	self assert: (portfolioSummary at: 2) equals: 'Depósito por 80 pesos'.
	self assert: (portfolioSummary  at: 3) equals: 'Balance = 100 pesos'.! !

!ReportsTest methodsFor: 'tests' stamp: 'MS 12/14/2020 20:29:31'!
test08NetTransfersOfAnAccountWithoutTransactionsIsZero
	| account transferNet |
	
	account := ReceptiveAccount new.
	
	transferNet := TransferNet for: account.
	transferNet := transferNet generateReport.
	
	self assert: transferNet equals: 0 * peso.! !

!ReportsTest methodsFor: 'tests' stamp: 'MS 12/14/2020 20:31:10'!
test09NetTransfersOfAccountsWithTransfersIsValid
	| account1 account2 transferNetOfAccount1 transferNetOfAccount2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit register: 150 * peso on: account1.
	Transfer amount: 100 * peso from: account1 to: account2.
	
	transferNetOfAccount1 := TransferNet for: account1.
	transferNetOfAccount2 := TransferNet for: account2.
	transferNetOfAccount1 := transferNetOfAccount1 generateReport.
	transferNetOfAccount2 := transferNetOfAccount2 generateReport.
	
	self assert: transferNetOfAccount1 equals: -100 * peso.
	self assert: transferNetOfAccount2 equals: 100 * peso.! !

!ReportsTest methodsFor: 'tests' stamp: 'MS 12/14/2020 20:34:24'!
test10NetTransfersOfAPortfolioWithoutTransactionsIsZero
	| portfolio account transferNet |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: account.
	
	transferNet := TransferNet for: account.
	transferNet := transferNet generateReport.
	
	self assert: transferNet equals: 0 * peso.! !

!ReportsTest methodsFor: 'tests' stamp: 'MS 12/14/2020 20:35:23'!
test11NetTransfersOfAPortfolioWithTransfersIsValid
	| account1 account2 portfolio transferNet |
	
	portfolio := Portfolio new.
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	portfolio add: account1.
		
	Deposit register: 150 * peso on: account1.
	Transfer amount: 100 * peso from: account1 to: account2.
	
	transferNet := TransferNet for: portfolio.
	transferNet := transferNet generateReport.
	
	self assert: transferNet equals: -100 * peso.! !


!ReportsTest methodsFor: 'tests - bonus track' stamp: 'MS 12/14/2020 21:02:47'!
test01

	"| account portfolio portfolioTreePrinter |
	account := ReceptiveAccount named: 'Cuenta mía'. 
	portfolio := Portfolio named: 'Portfolio de la familia' with: account.
	
	portfolioTreePrinter := PortfolioTreePrinter new.
	portfolioTreePrinter := portfolioTreePrinter generateReport.

	self assert: (portfolioTreePrinter at: 1) equals: 'Portfolio de la familia'.
	self assert: (portfolioTreePrinter at: 2) equals: (String tab, 'Cuenta mía')."! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Solucion-Portfolio'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 21:07:03'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 8 * peso equals: originAccount balance.
	self assert: 12 * peso equals: destinationAccount balance.! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:02:36'!
test05OriginAndDestinationAccountsCannotBeTheSame

	| originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	self should: [ Transfer amount: 2 * peso from: originAccount to: originAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToOriginErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:02:44'!
test06CannotTransferAZeroAmount

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 5 * peso on: destinationAccount.
	
	self should: [ Transfer amount: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !


!classDefinition: #Account category: 'ServiciosFinancieros-Solucion-Portfolio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'MS 12/14/2020 20:01:00'!
executeOverTransactions: aBlock
	
	self subclassResponsibility.! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!Account methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !

!Account methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Solucion-Portfolio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'main protocol' stamp: 'LL 9/21/2020 01:35:22'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 * peso ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'MS 12/14/2020 19:49:24'!
executeOverTransactions: aBlock
	
	accounts do: [ :anAccount | anAccount executeOverTransactions: aBlock ].! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'LL 9/20/2020 17:05:33'!
hasAccount: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'LL 9/20/2020 17:09:01'!
hasAccounts
	
	^accounts isEmpty ! !


!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Solucion-Portfolio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Solucion-Portfolio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'LL 9/20/2020 17:01:23'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'LL 9/21/2020 01:35:28'!
balance

	^transactions 
		inject: 0 * peso
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'MS 12/14/2020 20:37:02'!
executeOverTransactions: aBlock

	transactions do: aBlock.! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'LL 9/20/2020 20:53:32'!
hasRegistered: aTransaction

	^transactions includes: aTransaction
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !


!ReceptiveAccount methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Solucion-Portfolio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'reports' stamp: 'MS 12/14/2020 20:38:36'!
dispatchReport: aReport

	self subclassResponsibility.! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Solucion-Portfolio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Solucion-Portfolio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'reports' stamp: 'MS 12/14/2020 20:40:03'!
dispatchReport: aReport

	^aReport executeForDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Solucion-Portfolio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros-Solucion-Portfolio'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !


!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros-Solucion-Portfolio'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 22:45:01'!
of: aTransfer on: anAccount

	| transaction |
	
	transaction := self new initializeWith: 	aTransfer.
	anAccount register: transaction.	
	
	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros-Solucion-Portfolio'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!TransferDepositLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:49'!
affectBalance: aBalance

	^aBalance + self value! !


!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !



!TransferDepositLeg methodsFor: 'reports' stamp: 'MS 12/14/2020 20:41:26'!
dispatchReport: aReport

	^aReport executeForTransferDeposit: self.! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros-Solucion-Portfolio'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!TransferWithdrawLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:55'!
affectBalance: aBalance

	^aBalance - self value! !



!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'reports' stamp: 'MS 12/14/2020 20:41:26'!
dispatchReport: aReport

	^aReport executeForTransferWithdraw: self.! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Solucion-Portfolio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'reports' stamp: 'MS 12/14/2020 20:41:26'!
dispatchReport: aReport

	^aReport executeForWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Solucion-Portfolio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Reports category: 'ServiciosFinancieros-Solucion-Portfolio'!
Object subclass: #Reports
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!Reports methodsFor: 'initialization' stamp: 'MS 12/14/2020 20:47:10'!
initializeWith: anAccount

	self subclassResponsibility.! !


!Reports methodsFor: 'reports' stamp: 'MS 12/14/2020 20:25:23'!
executeForDeposit: aDeposit

	self subclassResponsibility.! !

!Reports methodsFor: 'reports' stamp: 'MS 12/14/2020 20:26:22'!
executeForTransferDeposit: aTransferDeposit

	self subclassResponsibility.! !

!Reports methodsFor: 'reports' stamp: 'MS 12/14/2020 20:26:07'!
executeForTransferWithdraw: aTransferWithdraw

	self subclassResponsibility.! !

!Reports methodsFor: 'reports' stamp: 'MS 12/14/2020 20:26:32'!
executeForWithdraw: aWithdraw

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Reports class' category: 'ServiciosFinancieros-Solucion-Portfolio'!
Reports class
	instanceVariableNames: ''!

!Reports class methodsFor: 'instance creation' stamp: 'MS 12/14/2020 20:46:09'!
for: anAccount

	self subclassResponsibility.! !


!classDefinition: #AccountSummary category: 'ServiciosFinancieros-Solucion-Portfolio'!
Reports subclass: #AccountSummary
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!AccountSummary methodsFor: 'initialization' stamp: 'jcb 12/13/2020 19:40:19'!
initializeWith: anAccount
	
	account := anAccount.! !


!AccountSummary methodsFor: 'reports' stamp: 'MS 12/14/2020 20:17:02'!
executeForDeposit: aDeposit

	^'Depósito por ', (aDeposit value) asString.! !

!AccountSummary methodsFor: 'reports' stamp: 'MS 12/14/2020 20:17:34'!
executeForTransferDeposit: aTransferDeposit

	^'Entrada por transferencia de ', (aTransferDeposit value) asString.! !

!AccountSummary methodsFor: 'reports' stamp: 'MS 12/14/2020 20:18:01'!
executeForTransferWithdraw: aTransferWithdraw

	^'Salida por transferencia de ', (aTransferWithdraw value) asString.! !

!AccountSummary methodsFor: 'reports' stamp: 'MS 12/14/2020 20:18:26'!
executeForWithdraw: aWithdraw

	^'Extracción por ', (aWithdraw value) asString.! !

!AccountSummary methodsFor: 'reports' stamp: 'MS 12/14/2020 20:40:03'!
generateReport
	| report |
	report := OrderedCollection new.
	
	account executeOverTransactions: [ :aTransaction | report add: (aTransaction dispatchReport: self) ].	
	
	report add: ('Balance = ', (account balance) asString).
	^report! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'ServiciosFinancieros-Solucion-Portfolio'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'MS 12/14/2020 20:45:31'!
for: anAccount

	^self new initializeWith: anAccount.! !


!classDefinition: #PortfolioTreePrinter category: 'ServiciosFinancieros-Solucion-Portfolio'!
Reports subclass: #PortfolioTreePrinter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!


!classDefinition: #TransferNet category: 'ServiciosFinancieros-Solucion-Portfolio'!
Reports subclass: #TransferNet
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!TransferNet methodsFor: 'initialization' stamp: 'MS 12/14/2020 20:06:09'!
initializeWith: anAccount
	
	account := anAccount.! !


!TransferNet methodsFor: 'reports' stamp: 'MS 12/14/2020 20:22:53'!
executeForDeposit: aDeposit

	^0.! !

!TransferNet methodsFor: 'reports' stamp: 'MS 12/14/2020 20:24:43'!
executeForTransferDeposit: aTransferDeposit

	^aTransferDeposit value.! !

!TransferNet methodsFor: 'reports' stamp: 'MS 12/14/2020 20:24:24'!
executeForTransferWithdraw: aTransferWithdraw

	^aTransferWithdraw value negated.! !

!TransferNet methodsFor: 'reports' stamp: 'MS 12/14/2020 20:23:25'!
executeForWithdraw: aWithdraw

	^0.! !

!TransferNet methodsFor: 'reports' stamp: 'MS 12/14/2020 21:22:22'!
generateReport

	| transferNet |
	transferNet := 0 * peso.
	
	account executeOverTransactions: [ :aTransaction | transferNet := transferNet + (aTransaction dispatchReport: self) ].	
	
	^transferNet .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'ServiciosFinancieros-Solucion-Portfolio'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'instance creation' stamp: 'MS 12/14/2020 20:45:42'!
for: anAccount

	^self new initializeWith: anAccount.! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Solucion-Portfolio'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion-Portfolio'!

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Solucion-Portfolio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 23:11:34'!
amount: anAmountOfMoney from: originAccount to: destinationAccount 
	
	| transfer depositLeg withdrawLeg |
	
	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.
	
	transfer := self new.
	
	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.
	
	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg
	
	
	! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription
	
	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin
	
	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !
