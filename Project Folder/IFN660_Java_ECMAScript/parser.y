%namespace IFN660_Java_ECMAScript
%union
{
    public long num;
	public float floatnum;
	public bool boolval;
	public char charval;
    public string name;
}

%token <num> NUMBER
%token <name> IDENTIFIER

// 3.9 Keywords
%token ABSTRACT   CONTINUE   FOR          NEW         SWITCH
%token ASSERT     DEFAULT    IF           PACKAGE     SYNCHRONIZED
%token BOOL	      DO         GOTO         PRIVATE     THIS
%token BREAK      DOUBLE     IMPLEMENTS   PROTECTED   THROW
%token BYTE       ELSE       IMPORT       PUBLIC      THROWS
%token CASE       ENUM       INSTANCEOF   RETURN      TRANSIENT
%token CATCH      EXTENDS    INT          SHORT       TRY
%token CHAR       FINAL      INTERFACE    STATIC      VOID
%token CLASS      FINALLY    LONG         STRICTFP    VOLATILE
%token CONST      FLOAT      NATIVE       SUPER       WHILE

// 3.10 Literals
%token <intnum> IntegerLiteral
%token <floatnum> FloatingPointLiteral
%token <boolval> BooleanLiteral
%token <charval> CharacterLiteral
%token <name> StringLiteral
%token NullLiteral

// 3.11 Separators
%token '(' ')' '{' '}' '[' ']' 
%token ';' ',' '.' '@'
%token ELLIPSIS DOUBLE_COLON

// 3.12 Operators
%token '=' '>' '<' '!' '~' '?' ':' 
%token '+' '-' '*' '/' '&' '|' '^' '%'
%token EQUAL GREATER_OR_EQUAL LESS_THAN_OR_EQUAL NOT_EQUAL
%token ARROW LOGICAL_AND LOGICAL_OR INCREMENT DECREMENT
%token LEFT_SHIFT SIGNED_RIGHT_SHIFT UNSIGNED_RIGHT_SHIFT
%token ADDITION_ASSIGNMENT SUBTRACTION_ASSIGNMENT
%token MULTIPLICATION_ASSIGNMENT DIVISION_ASSIGNMENT MODULUS_ASSIGNMENT
%token BITWISE_AND_ASSIGNMENT BITWISE_OR_ASSIGNMENT BITWISE_XOR_ASSIGNMENT
%token LEFT_SHIFT_ASSIGNMENT UNSIGNED_RIGHT_SHIFT_ASSIGNMENT SIGNED_RIGHT_SHIFT_ASSIGNMENT

%left '='
%nonassoc '<'
%left '+'

%%

Program : CompilationUnit										{ // Nathan }
        ;

Statement : IF '(' Expression ')' Statement ELSE Statement		{ // Nathan }
          | '{' StatementList '}'								{ // Nathan }
          | Expression ';'										{ // Nathan }
          | Type IDENTIFIER ';'									{ // Nathan }
		  | StatementWithoutTrailingSubstatement				{ // Nathan }
          ;

Type	: IntegerLiteral										{ // Tri }
		| BooleanLiteral										{ // Tri }
		;

StatementList 
		: StatementList Statement								{ // Tri }
        | /* empty */											{ // Tri }
        ;

Expression 
		: IntegerLiteral										{ // Tri }
        | IDENTIFIER											{ // Tri }	
        | Expression '=' Expression								{ // Tri }
        | Expression '+' Expression								{ // Tri }
        | Expression '<' Expression								{ // Josh }
		| AssignmentExpression									{ // Josh }
		  
           ;
Empty	:
		;

// Group A Start
CompilationUnit 
		: PackageDeclaration_opt ImportDeclarations TypeDeclarations	{ // Josh }
		;

PackageDeclaration_opt
		: /* empty */											{ // Josh }
		| /* follow up */
		;
		
ImportDeclarations
		: /*empty*/												{ // Josh }
		| /* follow up */
		;

TypeDeclarations 
		: TypeDeclaration TypeDeclarations
		| /* empty */											{ // Josh }
		| /* follow up */
		;
TypeDeclaration 
		: ClassDeclaration /* need to add InterfaceDeclaration */ { // Vivian }
		;

ClassDeclaration 
		: NormalClassDeclaration /* need to add EnumDeclaration */ { // Vivian }
		;

NormalClassDeclaration 
		: ClassModifiers CLASS IDENTIFIER TypeParameters_opt SuperClass_opt Superinterfaces_opt ClassBody { // Vivian }
		;

ClassModifiers 
		: ClassModifiers ClassModifier							{ // Vivian }
		| /* empty */											{ // Vivian }
		;

ClassModifier 
		: Annotation											{ // Adon }
		| PUBLIC												{ // Adon }
		| PROTECTED 											{ // Adon }
		| PRIVATE 												{ // Adon }
		| ABSTRACT 												{ // Adon }
		| STATIC 												{ // Adon }
		| FINAL 												{ // Adon }
		| STRICTFP 												{ // Adon }
		;

Annotation
		: /* empty */											{ // Tristan }
		;

//GROUP C TRACKING
TypeParameters_opt : /* empty */								{ // Tristan }
		;

SuperClass_opt : /* empty */									{ // Tristan }
		;

Superinterfaces_opt : /* empty */								{ // Tristan }
		;

ClassBody 
		: '{' ClassBodyDeclarations '}'							{ // Tristan }
		;

// Group A End

// PartB by Adon Mofified by Josh to remove MemberDeclarations as it is unessisary
ClassBodyDeclarations
		: ClassBodyDeclarations ClassBodyDeclaration			{ // Tristan }
		| /* empty */											{ // Tristan }
        ;

ClassBodyDeclaration
		: ClassMemberDeclaration								{ // Tristan }
        ;

// Fixed by An
ClassMemberDeclaration
		: MethodDeclaration										{ // Sneha }
		;

// Change ClassMemberDeclaration to MethodDeclaration -An	
MethodDeclaration
		: MethodModifiers MethodHeader MethodBody				{ // Sneha }
        ;

MethodModifiers
        : MethodModifiers MethodModifier						{ // Sneha }
		| /* Empty */											{ // Sneha }
        ;

MethodModifier
		: Annotation											{ // Sneha }
		| PUBLIC												{ // Sneha }
        | STATIC												{ // Sneha }
        ;

MethodHeader
		: Result MethodDeclarator Throws_opt					{ // Khoa }
        ;

// End Fix
// End GroupB

//WORK BY JOSH HUDSON
Result 
		: VOID													{ // Khoa }
		| UnannType												{ // Khoa }
	   	;

Throws_opt
		: Empty													{ // Khoa }
	  	;

// Fixed spelling error	 
MethodDeclarator
		: IDENTIFIER '(' FormalParameterList_Opt ')' Dims_Opt	{ // Khoa }
		;

/* Removed by Nathan
Identifier
		: Main													{ // Khoa }
		;
*/
//PLACEHOLDER - Josh - Tri
FormalParameterList_Opt
		: FormalParameterList									{ // An }
		| /* empty */											{ // An }
		;

Dims_Opt 
		: Dims													{ // An }
		| /* Empty */											{ // An }
		;
// JOSHUA'S WORK END

//Work by Tri
FormalParameterList 
		: FormalParameters 										{ // An }
		| /*TODO*/												{ // An }
		;

FormalParameters 
		: FormalParameter FormalParameter_repeat 				{ // Nathan }
		| /* empty *//*TODO*/									{ // Nathan }
		;
FormalParameter_repeat
		: ',' FormalParameter_repeat FormalParameter			{ // Nathan }
		| /* empty */											{ // Nathan }
		;

FormalParameter 
		:  VariableModifiers UnannType VariableDeclaratorId		{ // Nathan }
		;
VariableModifiers 
		: VariableModifiers VariableModifier					{ // Nathan }
		| /* empty */											{ // Nathan }
		;

VariableModifier 
		: Annotation											{ // Tri }
		| FINAL													{ // Tri }
		;

//End work by Tri
// Work by Vivian
Dims
		: Annotations '['']'									{ // Tri }
		;

VariableDeclaratorId
		: IDENTIFIER Dims_Opt									{ // Tri }
		;

UnannType
		: UnannReferenceType									{ // Tri }
		| UnannPrimitiveType									{ // Tri }
		;

UnannPrimitiveType
		: NumbericType											{ // Josh }
		| BOOL													{ // Josh }
		;

NumbericType
		: IntegralType											{ // Josh }
		| FloatingPointType										{ // Josh }
		;

IntegralType
		: BYTE													{ // Josh }
		| SHORT													{ // Josh }
		| INT													{ // Vivian }
		| LONG													{ // Vivian }
		| CHAR													{ // Vivian }
		;

FloatingPointType
		: FLOAT													{ // Vivian }
		| DOUBLE												{ // Vivian }
		;

UnannReferenceType
		: UnannArrayType										{ // Vivian }
		| /*follow up */										{ // Vivian }
		;

// Vivian's work end
// Work by Khoa - Fixed by An
UnannArrayType
		: UnannTypeVariable Dims								{ // Adon }
		;	
			
UnannTypeVariable
		: IDENTIFIER											{ // Adon }
		;	

// Start work by An
MethodBody
		:  Block 												{ // Adon }
		| ';'													{ // Adon }
		;

Annotations
		: Annotation											{ // Adon }
		| /* Empty */											{ // Adon }
		;

Block 
		: '{' BlockStatements_Opt '}'							{ // Tristan }
		;

BlockStatements_Opt
		: BlockStatements										{ // Tristan }
		| /* Empty */											{ // Tristan }
		;

BlockStatements
		: BlockStatement BlockStatement_s						{ // Tristan }
		;

BlockStatement_s
		: BlockStatement_s BlockStatement						{ // Tristan }
		| /* Empty */											{ // Tristan }
		;

BlockStatement
		: LocalVariableDeclarationsAndStatement					{ // Sneha }
		| Statement												{ // Sneha }
		| /* follow up */										{ // Sneha }
		;

LocalVariableDeclarationsAndStatement
		: LocalVariableDeclaration ';'							{ // Sneha }
		;

LocalVariableDeclaration
		: UnannType VariableDeclaratorList						{ // Sneha }
		| /* follow up */										{ // Sneha }
		;

VariableDeclaratorList
		: VariableDeclarator									{ // An }
		| /* follow up */										{ // An }
		;

VariableDeclarator
		: VariableDeclaratorId									{ // An }
		| /* follow up */										{ // An }
		;

VariableDeclaratorId
		: IDENTIFIER Dims_Opt									{ // An }
		;

// Tristan
StatementWithoutTrailingSubstatement
		: ExpressionStatement 									{ // An }
		;

ExpressionStatement
		: StatementExpression ';'								{ // Khoa }
		;

StatementExpression
		: Assignment											{ // Khoa }
		;

// End Work by Tristan
//work by sneha

Assignment
		: LeftHandSide AssignmentOperator Expression			{ // Khoa }
		;

LeftHandSide
		: ExpressionName										{ // Khoa }
		;

ExpressionName
		: IDENTIFIER											{ // Khoa }
		;

AssignmentOperator
		: '='													{ // Khoa }
		;

AssignmentExpression
		: ArrayAccess											{ // Nathan }
		;

ArrayAccess
		: PrimaryNoNewArray										{ // Nathan }
		;

PrimaryNoNewArray
		: Literal												{ // Nathan }
		;

Literal
		: IntegerLiteral										{ // Nathan }
		;

// end of sneha Work

%%

public Parser(Scanner scanner) : base(scanner)
{
}

