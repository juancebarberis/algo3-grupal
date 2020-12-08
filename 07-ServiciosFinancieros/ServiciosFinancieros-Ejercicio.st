!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

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

!PortfolioTest methodsFor: 'tests' stamp: 'jcb 12/6/2020 20:54:33'!
test07BalanceOfAPortfolioCanBeVerified

	| portfolio sharedAccount1 sharedAccount2 |
	
	sharedAccount1 := ReceptiveAccount new.
	sharedAccount2 := ReceptiveAccount new.
	
	portfolio := Portfolio new.
	portfolio add: sharedAccount1.
	portfolio add: sharedAccount2.
	
	Deposit register: 20 * peso on: sharedAccount1. 
	Deposit register: 60 * peso on: sharedAccount2.
	
	Withdraw register: 10 * peso on: sharedAccount1.
	Withdraw register: 20 * peso on: sharedAccount2.
	
	self assert: (portfolio balance) equals: 50 * peso! !

!PortfolioTest methodsFor: 'tests' stamp: 'jcb 12/6/2020 21:02:02'!
test08AccountInPortfolioRegisterATransaction

	| portfolio sharedAccount1 sharedAccount2 transactionToAssert |
	
	sharedAccount1 := ReceptiveAccount new.
	sharedAccount2 := ReceptiveAccount new.
	
	portfolio := Portfolio new.
	portfolio add: sharedAccount1.
	portfolio add: sharedAccount2.
	
	Deposit register: 20 * peso on: sharedAccount1. 
	Deposit register: 60 * peso on: sharedAccount2.
	
	Withdraw register: 10 * peso on: sharedAccount1.
	transactionToAssert := Withdraw register: 20 * peso on: sharedAccount2.
	
	self assert: (portfolio hasRegistered: transactionToAssert)! !

!PortfolioTest methodsFor: 'tests' stamp: 'jcb 12/6/2020 21:06:03'!
test09AccountNotInPortfolioRegisterATransaction

	| portfolio sharedAccount1 sharedAccount2 sharedAccount3 transactionToAssert |
	
	sharedAccount1 := ReceptiveAccount new.
	sharedAccount2 := ReceptiveAccount new.
	sharedAccount3 := ReceptiveAccount new.	
	
	portfolio := Portfolio new.
	portfolio add: sharedAccount1.
	portfolio add: sharedAccount2.
	
	Deposit register: 20 * peso on: sharedAccount1. 
	Deposit register: 60 * peso on: sharedAccount2.
	
	Withdraw register: 10 * peso on: sharedAccount1.
	transactionToAssert := Deposit register: 20 * peso on: sharedAccount3.
	
	self deny: (portfolio hasRegistered: transactionToAssert)! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:01:58'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:55:33'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:55:48'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:55:54'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:56:01'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:56:08'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTest methodsFor: 'tests' stamp: 'jcb 12/6/2020 20:47:02'!
test01ATransferIsRegisteredBetweenTwoAccountsForAValue
	| account1 account2 |
	account1  := ReceptiveAccount new.
	account2  := ReceptiveAccount new.	
	
	Deposit register: 100 * peso on: account1.
	Transfer register: 20 * peso from: account1 to: account2.
	
	self assert: 80 * peso equals: account1 balance.
	self assert: 20 * peso equals: account2 balance.! !

!TransferTest methodsFor: 'tests' stamp: 'jcb 12/6/2020 20:47:51'!
test02TheValueOfATransferCanBeVerified
	| account1 account2 transfer |
	account1  := ReceptiveAccount new.
	account2  := ReceptiveAccount new.	
	
	Deposit register: 100 * peso on: account1.
	transfer := Transfer register: 20 * peso from: account1 to: account2.
		
	self assert: (transfer value) equals: 20 * peso.
	! !

!TransferTest methodsFor: 'tests' stamp: 'jcb 12/6/2020 20:48:41'!
test03TheCounterpartOfATransferSideCanBeVerified
	| account1 account2 transfer transferCredit transferDebit |
	
	account1  := ReceptiveAccount new.
	account2  := ReceptiveAccount new.	
	
	Deposit register: 100 * peso on: account1.
	transfer := Transfer register: 20 * peso from: account1 to: account2.
		
	transferDebit := transfer debit.	
	transferCredit := transfer credit.
	
	self assert: (transferDebit counterpart) equals: transferCredit.
	self assert: (transferCredit counterpart) equals: transferDebit.
	
	! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Transfer
	instanceVariableNames: 'value credit debit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transfer methodsFor: 'initialization' stamp: 'jcb 12/8/2020 16:04:59'!
initializeWith: aValue from: aSendingAccount to: aReceivingAccount

	value := aValue.
	
	credit := TransferDeposit with: aValue.
	debit := TransferWithdraw with: aValue.	
	
	credit setCounterpart: debit.
	debit setCounterpart: credit.	
	
	aSendingAccount register: debit.
	aReceivingAccount register: credit.! !


!Transfer methodsFor: 'accessing' stamp: 'jcb 12/6/2020 20:25:06'!
counterpart
	
	^self subclassResponsibility ! !

!Transfer methodsFor: 'accessing' stamp: 'jcb 12/6/2020 19:48:20'!
credit
	^credit! !

!Transfer methodsFor: 'accessing' stamp: 'jcb 12/6/2020 19:48:14'!
debit
	^debit! !

!Transfer methodsFor: 'accessing' stamp: 'jcb 12/8/2020 16:01:48'!
value
	^value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'jcb 12/6/2020 19:08:17'!
register: aValue from: aSendingAccount to: aReceivingAccount 
		
	^self new initializeWith: aValue from: aSendingAccount to: aReceivingAccount.! !



!classDefinition: #TransferDeposit category: 'ServiciosFinancieros-Ejercicio'!
Transfer subclass: #TransferDeposit
	instanceVariableNames: 'counterpart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferDeposit methodsFor: 'initialization' stamp: 'jcb 12/8/2020 15:58:57'!
initializeWith: aValue

	value := aValue.! !


!TransferDeposit methodsFor: 'accessing' stamp: 'jcb 12/6/2020 20:18:51'!
counterpart
	^counterpart! !

!TransferDeposit methodsFor: 'accessing' stamp: 'jcb 12/6/2020 20:17:03'!
credit
	^self! !

!TransferDeposit methodsFor: 'accessing' stamp: 'jcb 12/6/2020 20:18:14'!
debit
	^debit! !

!TransferDeposit methodsFor: 'accessing' stamp: 'jcb 12/6/2020 20:32:53'!
value 
	^value! !


!TransferDeposit methodsFor: 'setter' stamp: 'jcb 12/6/2020 20:24:10'!
setCounterpart: aCounterpart

	counterpart := aCounterpart! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: 'ServiciosFinancieros-Ejercicio'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'initialization' stamp: 'jcb 12/6/2020 19:46:19'!
with: aValue
	^self new initializeWith: aValue.! !


!classDefinition: #TransferWithdraw category: 'ServiciosFinancieros-Ejercicio'!
Transfer subclass: #TransferWithdraw
	instanceVariableNames: 'counterpart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferWithdraw methodsFor: 'initialization' stamp: 'jcb 12/6/2020 19:47:28'!
initializeWith: aValue
	value := aValue.! !


!TransferWithdraw methodsFor: 'accessing' stamp: 'jcb 12/6/2020 20:18:36'!
counterpart
	^counterpart! !

!TransferWithdraw methodsFor: 'accessing' stamp: 'jcb 12/6/2020 20:17:13'!
debit
	^self! !

!TransferWithdraw methodsFor: 'accessing' stamp: 'jcb 12/6/2020 20:33:01'!
value
	^value! !


!TransferWithdraw methodsFor: 'setter' stamp: 'jcb 12/6/2020 20:24:25'!
setCounterpart: aCounterpart

	counterpart := aCounterpart! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: 'ServiciosFinancieros-Ejercicio'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'as yet unclassified' stamp: 'jcb 12/6/2020 19:46:38'!
with: aValue
	^self new initializeWith: aValue.! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'jcb 12/3/2020 21:21:26'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'jcb 12/3/2020 21:13:24'!
for: aValue

	^ self new initializeFor: aValue! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !


!Portfolio methodsFor: 'testing' stamp: 'LL 9/20/2020 17:05:33'!
hasAccount: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'testing' stamp: 'LL 9/20/2020 17:09:01'!
hasAccounts
	
	^accounts isEmpty ! !


!Portfolio methodsFor: 'accessing' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !


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


!Portfolio methodsFor: 'main protocol' stamp: 'jcb 12/6/2020 20:56:22'!
balance

	| balance |
	balance := 0.
	
	accounts do: [ :anAccount | 
		balance := balance + (anAccount balance)
		].
	
	^balance.
	! !

!Portfolio methodsFor: 'main protocol' stamp: 'jcb 12/6/2020 21:03:58'!
hasRegistered: aTransaction
	accounts do: [ :anAccount |
		(anAccount hasRegistered: aTransaction) ifTrue: [^true]
		].
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
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


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'LL 9/20/2020 17:01:23'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'jcb 12/6/2020 20:29:17'!
balance

	| balance |
	
	balance := 0.
	
	transactions do: [
		:aTransaction | 
			(aTransaction isKindOf: Deposit) ifTrue: [balance := balance + aTransaction value].
			(aTransaction isKindOf: Withdraw) ifTrue: [balance := balance - aTransaction value].
			(aTransaction isKindOf: TransferDeposit) ifTrue: [ balance := balance + aTransaction value ].
			(aTransaction isKindOf: TransferWithdraw) ifTrue: [ balance := balance - aTransaction value ].
		].
	
	^balance! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'LL 9/20/2020 20:48:29'!
hasRegistered: aTransaction

	^transactions includes: aTransaction
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'jcb 12/3/2020 21:09:53'!
register: aTransaction
	
	transactions add: aTransaction 
	! !


!ReceptiveAccount methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !
