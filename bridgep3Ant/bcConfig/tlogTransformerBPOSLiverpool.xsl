<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet extension-element-prefixes="fn trxHelper"
	version="1.0" xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:trxHelper="trxHelper" xmlns:lxslt="http://xml.apache.org/xslt"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<lxslt:component functions="" prefix="trxHelper">
		<lxslt:script lang="javaclass"
			src="com.synthesis.bridge.bcore.business.util.TransformedTrxHelper" />
	</lxslt:component>

	<xsl:output indent="yes" method="xml" encoding="ISO-8859-1" />
	<!-- <xsl:strip-space elements="ticket" /> -->

	<!-- Version de IxRetail -->
	<xsl:variable name="version" select="2.2" />
	<xsl:variable name="vTrue" select="trxHelper:getVTrue()" />
	<xsl:variable name="vFalse" select="trxHelper:getVFalse()" />

	<xsl:variable name="saleType" select="1" />
	<xsl:variable name="returnType" select="2" />

	<!-- Se definen las keys para obtener elementos mediante su atributo 'id' -->
	<xsl:key name="state" match="state" use="@id" />
	<xsl:key name="country" match="country" use="@id" />
	<xsl:key name="item" match="item" use="@id" />
	<xsl:key name="operationApproval" match="operationApproval"
		use="@id" />
	<xsl:key name="type" match="type" use="@id" />
	<xsl:key name="jurisdictionAndType" match="jurisdictionAndType"
		use="@id" />
	<xsl:key name="taxCategory" match="taxCategory" use="@id" />
	<xsl:key name="jurisdiction" match="jurisdiction" use="@id" />


	<!-- ************************************************************************************* -->
	<!-- root template -->
	<xsl:template match="/ticket" name="RetailTransaction">

		<PosLog>
			<GsaTlog>
				<xsl:value-of select="gsaTlog" />
			</GsaTlog>
			<GsaEj>
				<xsl:value-of select="gsaEj" />
			</GsaEj>
			<testName>
				<xsl:value-of select="testName" />
			</testName>
			<vtolStoreMessages>
				<xsl:value-of select="vtolStoreMessages" />
			</vtolStoreMessages>

			<Transaction>
				<xsl:call-template name="ProcesarTransactionHeader" />

				<RetailTransaction>
					<xsl:attribute name="Version">
					<xsl:value-of select="$version" />
				</xsl:attribute>

					<TypeCode>
						<xsl:value-of select="type/@name" />
					</TypeCode>

					<OriginalSequenceNumber>
						<xsl:value-of select="originalTrxNumber" />
					</OriginalSequenceNumber>
					<OriginalWorstationId>
						<xsl:value-of select="originalTerminalNumber" />
					</OriginalWorstationId>
					<OriginalRetailStoreID>
						<xsl:value-of select="originalStoreNumber" />
					</OriginalRetailStoreID>
					<OriginalTransactionDate>
						<xsl:value-of select="originalTrxDate" />
					</OriginalTransactionDate>
					<OriginalBillType>
						<xsl:value-of select="originalBillType" />
					</OriginalBillType>
					<OriginalSerieOfficialBill>
						<xsl:value-of select="originalSerieOfficialBill" />
					</OriginalSerieOfficialBill>
					<OriginalFiscalPOSNumber>
						<xsl:value-of select="originalFiscalPOSNumber" />
					</OriginalFiscalPOSNumber>
					<OriginalBillNumber>
						<xsl:value-of select="originalBillNumber" />
					</OriginalBillNumber>

					<xsl:if test="not(not(customerOrderIdentification))">
						<CustomerOrderIdentification>
							<WorkstationId>
								<xsl:value-of select="customerOrderIdentification/terminalCode" />
							</WorkstationId>
							<SequenceNumber>
								<xsl:value-of select="customerOrderIdentification/seqNumber" />
							</SequenceNumber>
							<RetailStoreID>
								<xsl:value-of select="customerOrderIdentification/storeCode" />
							</RetailStoreID>
							<Date>
								<xsl:value-of select="customerOrderIdentification/date" />
							</Date>
						</CustomerOrderIdentification>
					</xsl:if>

					<OfficialBill>
						<BillType>
							<xsl:value-of select="billType" />
						</BillType>
						<SerieOfficialBill>
							<xsl:value-of select="serieOfficialBill" />
						</SerieOfficialBill>
						<FiscalPOSNumber>
							<xsl:value-of select="fiscalPosNumber" />
						</FiscalPOSNumber>
						<BillNumber>
							<xsl:value-of select="docNumber" />
						</BillNumber>
						<AmountOfBill>
							<xsl:value-of
								select="trxHelper:scale((total >= 0)*total - not(total >= 0)*total)" />
						</AmountOfBill>
					</OfficialBill>

					<POSEODSequenceNumber>
						<xsl:value-of select="currentZNumber" />
					</POSEODSequenceNumber>
					<FiscalControllerNumber>
						<xsl:value-of select="fiscalControllerNumber" />
					</FiscalControllerNumber>
					<FiscalPOSNumber>
						<xsl:value-of select="fiscalPosNumber" />
					</FiscalPOSNumber>

					<xsl:call-template name="ProcesarComprobanteFiscalCerrado" />

					<xsl:if
						test="not(not(properties/entry[string='trxCashdrawerOpeningRequested']/boolean))">
						<xsl:if
							test="properties/entry[string='trxCashdrawerOpeningRequested']/boolean = $vTrue">
							<CashdrawerOpeningRequested>true</CashdrawerOpeningRequested>
						</xsl:if>
						<xsl:if
							test="properties/entry[string='trxCashdrawerOpeningRequested']/boolean = $vFalse">
							<CashdrawerOpeningRequested>false</CashdrawerOpeningRequested>
						</xsl:if>
					</xsl:if>
					<xsl:if
						test="not(properties/entry[string='trxCashdrawerOpeningRequested']/boolean)">
						<CashdrawerOpeningRequested>false</CashdrawerOpeningRequested>
					</xsl:if>

					<xsl:if test="type/@name='PaymentOnAccount'">
						<xsl:call-template name="ProcesarPaymentCreditAccountItems" />
					</xsl:if>

					<xsl:if test="type/@name='BalanceMonedero'">
						<xsl:call-template name="ProcesarMonederoLine" />
					</xsl:if>

					<xsl:if test="type/@name='recharge'">
						<xsl:call-template name="ProcesarMonederoLine" />
					</xsl:if>

					<xsl:if test="type/@name='transferBalance'">
						<xsl:call-template name="ProcesarMonederoLine" />
					</xsl:if>

					<xsl:if test="type/@name='refundRecharge'">
						<xsl:call-template name="ProcesarMonederoLine" />
					</xsl:if>
					<!-- xsl:if test="key('item', trxHelper:getNotNull(item/@reference, 
						item/@id))/internalCode='CP01'" -->
					<xsl:if test="type/@name!='PaymentOnAccount'">
						<xsl:call-template name="ProcesarSaleReturnItems" />
					</xsl:if>

					<xsl:call-template name="ProcesarDescuentos" />

					<xsl:call-template name="ProcesarPagos" />
					<xsl:call-template name="ProcesarVuelto" />

					<xsl:apply-templates select="customer" />

					<xsl:call-template name="CustomerTaxes" />

					<xsl:call-template name="ProcesarTotales" />

					<xsl:call-template name="ProcesarApprovals" />

					<RingElapsedTime>
						<xsl:value-of select="ringElapsedTime" />
					</RingElapsedTime>

					<TenderElapsedTime>
						<xsl:value-of select="tenderElapsedTime" />
					</TenderElapsedTime>

					<LockElapsedTime>
						<xsl:value-of select="lockTime" />
					</LockElapsedTime>

					<xsl:if test="cancelFlag=$vTrue">
						<CancelReasonCode>
							<xsl:value-of select="cancelReasonCode" />
						</CancelReasonCode>
					</xsl:if>

				</RetailTransaction>

				<!-- Aplica todos los templates y continua <xsl:apply-templates /> -->
			</Transaction>
			<xsl:call-template name="ProcesarEJ" />
			<xsl:call-template name="ProcesarAudit" />
		</PosLog>
	</xsl:template>

	<xsl:template name="CustomerTaxes">
		<xsl:for-each select="taxDetail">
			<LineItem>
				<SequenceNumber>
					<xsl:value-of select="trxHelper:newLineItemNumber()" />
				</SequenceNumber>
				<Tax>
					<xsl:attribute name="TaxType">
						<xsl:value-of select="taxType" />
					</xsl:attribute>
					<xsl:attribute name="TaxSubType">
						<xsl:value-of select="taxAuthority" />
					</xsl:attribute>
					<SequenceNumber>
						<xsl:value-of select="'1'" />
					</SequenceNumber>
					<Amount>
						<xsl:value-of select="trxHelper:scale(amount)" />
					</Amount>
					<xsl:if test="not(not(taxableAmount))">
						<TaxableAmount>
							<xsl:value-of select="trxHelper:scale(taxableAmount)" />
						</TaxableAmount>
					</xsl:if>
					<xsl:if test="not(not(taxablePercentage))">
						<Percent>
							<xsl:value-of select="trxHelper:scale(taxablePercentage)" />
						</Percent>
					</xsl:if>
					<xsl:if test="not(not(taxCertificatePercentage))">
						<TaxOverride>
							<OriginalTaxAmount>
								<xsl:value-of select="trxHelper:scale(originalAmount)" />
							</OriginalTaxAmount>
						</TaxOverride>
					</xsl:if>
				</Tax>
			</LineItem>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="ProcesarComprobanteFiscalCerrado">
		<xsl:if
			test="not(not(properties/entry[string='closedFiscalReceiptInCourseNumber']/string[2]))">
			<ClosedFiscalReceiptInCourse>
				<Number>
					<xsl:value-of
						select="properties/entry[string='closedFiscalReceiptInCourseNumber']/string[2]" />
				</Number>
				<TotalAmount>
					<xsl:value-of
						select="properties/entry[string='closedFiscalReceiptInCourseTotal']/string[2]" />
				</TotalAmount>
				<TotalIVAAmount>
					<xsl:value-of
						select="properties/entry[string='closedFiscalReceiptInCourseIVATotal']/string[2]" />
				</TotalIVAAmount>
			</ClosedFiscalReceiptInCourse>
		</xsl:if>
	</xsl:template>

	<xsl:template match="/transaction" name="NonSaleTransaction">
		<PosLog>
			<Transaction>
				<xsl:call-template name="ProcesarTransactionHeader" />
				<xsl:choose>
					<xsl:when test="type/@parentType = 4">
						<Assurances />
					</xsl:when>
					<xsl:when test="type/@parentType = 5">
						<Payments />
					</xsl:when>
					<xsl:when test="type/@parentType = 2">
						<xsl:call-template name="ProcesarControlTransaction" />
					</xsl:when>
					<xsl:when test="type/@parentType = 29">
						<xsl:call-template name="ProcesarControlTransaction" />
					</xsl:when>
					<xsl:when test="type/@parentType = 3">
						<xsl:call-template name="ProcesarTenderControlTransaction" />
					</xsl:when>
				</xsl:choose>

			</Transaction>

			<xsl:call-template name="ProcesarEJ" />
			<xsl:call-template name="ProcesarAudit" />
			<GsaTlog>
				<xsl:value-of select="gsaTlog" />
			</GsaTlog>
			<GsaEj>
				<xsl:value-of select="gsaEj" />
			</GsaEj>
			<testName>
				<xsl:value-of select="testName" />
			</testName>
		</PosLog>
	</xsl:template>

	<xsl:template match="/dailyClose" name="DailyCloseTransaction">
		<PosLog>
			<Transaction>
				<xsl:call-template name="ProcesarTransactionHeader" />
				<FiscalControllerNumber>
					<xsl:value-of select="fiscalControllerNumber" />
				</FiscalControllerNumber>
				<FiscalPOSNumber>
					<xsl:value-of select="fiscalPosNumber" />
				</FiscalPOSNumber>
				<ControlTransaction>
					<xsl:attribute name="Version">
					<xsl:value-of select="$version" />
				</xsl:attribute>
					<TypeCode>
						<xsl:value-of select="type/@name" />
					</TypeCode>
					<POSEOD>
						<xsl:attribute name="Type">
						<xsl:value-of select="docType" />
					</xsl:attribute>
						<POSEODSequenceNumber>
							<xsl:value-of select="docNumber" />
						</POSEODSequenceNumber>
						<LastTransactionSequenceNumber
							DocumentType="Ticket">
							<xsl:value-of select="lastTicketNumber" />
						</LastTransactionSequenceNumber>
						<LastTransactionSequenceNumber
							DocumentType="Invoice">0</LastTransactionSequenceNumber>
						<LastTransactionSequenceNumber
							DocumentType="Invoice" Serie="B">
							<xsl:value-of select="lastBOrCTypeInvoiceOrDebitNote" />
						</LastTransactionSequenceNumber>
						<LastTransactionSequenceNumber
							DocumentType="Invoice" Serie="A">
							<xsl:value-of select="lastATypeInvoiceOrDebitNote" />
						</LastTransactionSequenceNumber>
						<LastTransactionSequenceNumber
							DocumentType="CreditNote" Serie="B">
							<xsl:value-of select="lastBOrCTypeCreditNote" />
						</LastTransactionSequenceNumber>
						<TransactionCount DocumentType="CancelledFiscalDocument">
							<xsl:value-of select="voidedFiscalDocs" />
						</TransactionCount>
						<TransactionCount DocumentType="NonFiscalDocument">
							<xsl:value-of select="nonFiscalDocs" />
						</TransactionCount>
						<TransactionCount DocumentType="Ticket">
							<xsl:value-of select="tickets" />
						</TransactionCount>
						<Total TotalType="GrossPositiveAmount">
							<xsl:value-of select="salesAmount" />
						</Total>
						<Total TotalType="TaxAmount">
							<xsl:value-of select="vatAmount" />
						</Total>
						<Total TotalType="SpecialTaxAmount">
							<xsl:value-of select="internalTaxesAmount" />
						</Total>
						<Total TotalType="WithHoldingTaxAmount">
							<xsl:value-of select="perceptionsInCreditNotesAmount" />
						</Total>
						<Total TotalType="CreditNoteTotalAmount">
							<xsl:value-of select="creditNotesAmount" />
						</Total>
						<Total TotalType="CreditNoteVATAmount">
							<xsl:value-of select="vatInCreditNotesAmount" />
						</Total>
						<Total TotalType="CreditNoteSpecialTaxAmount">
							<xsl:value-of select="internalTaxesInCreditNotesAmount" />
						</Total>
						<Total TotalType="CreditNoteWithHoldingTaxAmount">
							<xsl:value-of select="perceptionsInCreditNotesAmount" />
						</Total>
					</POSEOD>

					<xsl:call-template name="ProcesarApprovals" />
				</ControlTransaction>
			</Transaction>
			<xsl:call-template name="ProcesarEJ" />
			<xsl:call-template name="ProcesarAudit" />
		</PosLog>
	</xsl:template>

	<xsl:template match="/posDailyClose" name="POSDailyCloseTransaction">
		<PosLog>
			<Transaction>
				<xsl:call-template name="ProcesarPOSDailyCloseTransactionHeader" />
				<ControlTransaction>
					<xsl:attribute name="Version">
					<xsl:value-of select="$version" />
				</xsl:attribute>
					<TypeCode>
						<xsl:value-of select="type/@name" />
					</TypeCode>
					<POSEOD>
						<xsl:value-of select="beginDateTime" />
					</POSEOD>
					<FiscalPOSNumber>
						<xsl:value-of select="fiscalPosNumber" />
					</FiscalPOSNumber>

					<xsl:call-template name="ProcesarApprovals" />

				</ControlTransaction>
			</Transaction>
			<xsl:call-template name="ProcesarEJ" />
			<xsl:call-template name="ProcesarAudit" />
		</PosLog>
	</xsl:template>

	<xsl:template match="/posFirstStart" name="POSFirstTransaction">
		<PosLog>
			<Transaction>
				<xsl:call-template name="ProcesarPOSDailyCloseTransactionHeader" />
				<ControlTransaction>
					<xsl:attribute name="Version">
					<xsl:value-of select="$version" />
				</xsl:attribute>
					<TypeCode>
						<xsl:value-of select="type/@name" />
					</TypeCode>
					<POSSOD>
						<xsl:value-of select="possod" />
					</POSSOD>
					<FiscalPOSNumber>
						<xsl:value-of select="fiscalPosNumber" />
					</FiscalPOSNumber>

					<xsl:call-template name="ProcesarApprovals" />

				</ControlTransaction>
			</Transaction>
			<xsl:call-template name="ProcesarEJ" />
			<xsl:call-template name="ProcesarAudit" />
		</PosLog>
	</xsl:template>

	<xsl:template name="ProcesarPOSDailyCloseTransactionHeader">
		<RetailStoreID>
			<xsl:value-of select="storeCode" />
		</RetailStoreID>
		<WorkstationID>
			<xsl:value-of select="terminalCode" />
		</WorkstationID>
		<SequenceNumber>
			<xsl:value-of select="transactionID/transactionNumber" />
		</SequenceNumber>
		<BusinessDayDate>
			<xsl:value-of select="businessDayDate" />
		</BusinessDayDate>
		<BeginDateTime>
			<xsl:value-of select="beginDateTime" />
		</BeginDateTime>
		<xsl:if test="not(not(endDateTime))">
			<EndDateTime>
				<xsl:value-of select="endDateTime" />
			</EndDateTime>
		</xsl:if>
		<OperatorID>
			<xsl:value-of select="userName" />
		</OperatorID>
		<Period>
			<xsl:value-of select="periodNumber" />
		</Period>
		<Subperiod>
			<xsl:value-of select="sbPeriodNumber" />
		</Subperiod>
		<OriginalTransaction>
			<!-- <xsl:value-of select="trxHelper:getEncodedTag()" /> -->
		</OriginalTransaction>
	</xsl:template>

	<xsl:template name="ProcesarTransactionHeader">
		<xsl:attribute name="CancelFlag">
			<xsl:value-of select="cancelFlag" />
		</xsl:attribute>
		<xsl:attribute name="TrainingModeFlag">
			<xsl:value-of select="trainingModeFlag" />
		</xsl:attribute>
		<xsl:attribute name="SuspendedFlag">
			<xsl:value-of select="suspendedFlag" />
		</xsl:attribute>
		<xsl:attribute name="VoidedFlag">
			<xsl:value-of select="voidedFlag" />
		</xsl:attribute>
		<xsl:attribute name="OfflineFlag">
			<xsl:value-of select="offlineFlag" />
		</xsl:attribute>
		<xsl:attribute name="ContigencyFlag">
			<xsl:value-of select="contigencyFlag" />
		</xsl:attribute>
		<RetailStoreID>
			<xsl:value-of select="storeCode" />
		</RetailStoreID>
		<WorkstationID>
			<xsl:value-of select="terminalCode" />
		</WorkstationID>
		<TillID>
			<xsl:value-of select="tillCode" />
		</TillID>
		<TillType>
			<xsl:value-of select="tillType" />
		</TillType>
		<SequenceNumber>
			<xsl:value-of select="transactionID/transactionNumber" />
		</SequenceNumber>
		<BusinessDayDate>
			<xsl:value-of select="businessDayDate" />
		</BusinessDayDate>
		<Period>
			<xsl:value-of select="periodNumber" />
		</Period>
		<Subperiod>
			<xsl:value-of select="sbPeriodNumber" />
		</Subperiod>
		<BeginDateTime>
			<xsl:value-of select="beginDateTime" />
		</BeginDateTime>
		<xsl:if test="not(not(endDateTime))">
			<EndDateTime>
				<xsl:value-of select="endDateTime" />
			</EndDateTime>
		</xsl:if>
		<OperatorID>
			<xsl:value-of select="userName" />
		</OperatorID>
		<OriginalTransaction>
			<!-- <xsl:value-of select="trxHelper:getEncodedTag()" /> -->
		</OriginalTransaction>
	</xsl:template>

	<!-- Para que no se muestren los valores fuera de los xml <xsl:template 
		match="/ticket/*"></xsl:template> <xsl:template match="/ticket"></xsl:template> -->

	<xsl:template name="ProcesarControlTransaction">
		<xsl:choose>
			<xsl:when test="type = 11">
				<ControlTransaction>
					<xsl:attribute name="Version">
						<xsl:value-of select="$version" />
					</xsl:attribute>
					<TypeCode>
						<xsl:value-of select="type/@name" />
					</TypeCode>
					<CashOpening />
					<xsl:call-template name="ProcesarApprovals" />
				</ControlTransaction>
			</xsl:when>
			<xsl:when test="type = 12">
				<ControlTransaction>
					<xsl:attribute name="Version">
						<xsl:value-of select="$version" />
					</xsl:attribute>
					<TypeCode>
						<xsl:value-of select="type/@name" />
					</TypeCode>
					<TransferTerminal />
					<xsl:call-template name="ProcesarApprovals" />
				</ControlTransaction>
			</xsl:when>
			<xsl:when test="type = 13">
				<ControlTransaction>
					<xsl:attribute name="Version">
						<xsl:value-of select="$version" />
					</xsl:attribute>
					<TypeCode>
						<xsl:value-of select="type/@name" />
					</TypeCode>
					<TrainingMode />
					<xsl:call-template name="ProcesarApprovals" />
				</ControlTransaction>
			</xsl:when>
			<xsl:when test="type = 14">
				<ControlTransaction>
					<xsl:attribute name="Version">
						<xsl:value-of select="$version" />
					</xsl:attribute>
					<TypeCode>
						<xsl:value-of select="type/@name" />
					</TypeCode>
					<RecoverTrx />
					<xsl:call-template name="ProcesarApprovals" />
				</ControlTransaction>
			</xsl:when>
			<xsl:when test="type = 15">
				<ControlTransaction>
					<xsl:attribute name="Version">
						<xsl:value-of select="$version" />
					</xsl:attribute>
					<TypeCode>
						<xsl:value-of select="type/@name" />
					</TypeCode>
					<SignOn />
					<xsl:call-template name="ProcesarApprovals" />
				</ControlTransaction>
			</xsl:when>
			<xsl:when test="type = 16">
				<ControlTransaction>
					<xsl:attribute name="Version">
						<xsl:value-of select="$version" />
					</xsl:attribute>
					<TypeCode>
						<xsl:value-of select="type/@name" />
					</TypeCode>
					<SignOff>
						<BeginDateTime>
							<xsl:value-of select="signBeginDateTime" />
						</BeginDateTime>
						<EndDateTime>
							<xsl:value-of select="signEndDateTime" />
						</EndDateTime>
					</SignOff>
					<xsl:call-template name="ProcesarApprovals" />
				</ControlTransaction>
			</xsl:when>
			<xsl:when test="type = 29">
				<ControlTransaction>
					<xsl:attribute name="Version">
						<xsl:value-of select="$version" />
					</xsl:attribute>
					<TypeCode>
						<xsl:value-of select="type/@name" />
					</TypeCode>
				</ControlTransaction>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="ProcesarTenderControlTransaction">
		<xsl:choose>
			<xsl:when test="type = 6">
				<TenderControlTransaction>
					<xsl:attribute name="Version">
						<xsl:value-of select="$version" />
					</xsl:attribute>
					<Totals>
						<Amount>
							<xsl:value-of select="total" />
						</Amount>
					</Totals>
					<TypeCode>
						<xsl:value-of select="type/@name" />
					</TypeCode>
					<TenderLoan>
						<SafeID>
							<xsl:value-of select="safeId" />
						</SafeID>
						<xsl:call-template name="ProcesarTenderControlTransactionItems" />
					</TenderLoan>
					<xsl:call-template name="ProcesarApprovals" />
				</TenderControlTransaction>
			</xsl:when>
			<xsl:when test="type = 7">
				<TenderControlTransaction>
					<xsl:attribute name="Version">
						<xsl:value-of select="$version" />
					</xsl:attribute>
					<Totals>
						<Amount>
							<xsl:value-of select="total" />
						</Amount>
					</Totals>
					<TypeCode>
						<xsl:value-of select="type/@name" />
					</TypeCode>
					<TenderPickup>
						<SafeID>
							<xsl:value-of select="safeId" />
						</SafeID>
						<xsl:call-template name="ProcesarTenderControlTransactionItems" />
					</TenderPickup>
					<xsl:call-template name="ProcesarApprovals" />
				</TenderControlTransaction>
			</xsl:when>
			<xsl:when test="type = 8">
				<TenderControlTransaction>
					<xsl:attribute name="Version">
						<xsl:value-of select="$version" />
					</xsl:attribute>
					<Totals>
						<Amount>
							<xsl:value-of select="total" />
						</Amount>
					</Totals>
					<TypeCode>
						<xsl:value-of select="type/@name" />
					</TypeCode>
					<TenderCount>
						<SafeID>
							<xsl:value-of select="safeId" />
						</SafeID>
						<xsl:call-template name="ProcesarTenderControlTransactionItems" />
					</TenderCount>
					<xsl:call-template name="ProcesarApprovals" />
				</TenderControlTransaction>
			</xsl:when>
			<xsl:when test="type = 9">
				<TenderControlTransaction>
					<xsl:attribute name="Version">
						<xsl:value-of select="$version" />
					</xsl:attribute>
					<TypeCode>
						<xsl:value-of select="type/@name" />
					</TypeCode>
					<TenderCorrection>
						<SafeID>
							<xsl:value-of select="safe/code" />
						</SafeID>
						<xsl:call-template name="ProcesarTenderCorrectionTransaction" />
					</TenderCorrection>
					<xsl:call-template name="ProcesarApprovals" />
				</TenderControlTransaction>
			</xsl:when>
			<xsl:when test="type = 10">
				<TenderControlTransaction>
					<xsl:attribute name="Version">
						<xsl:value-of select="$version" />
					</xsl:attribute>
					<TypeCode>
						<xsl:value-of select="type/@name" />
					</TypeCode>
					<ReceivedPaymentsReport />
					<xsl:call-template name="ProcesarApprovals" />
				</TenderControlTransaction>
			</xsl:when>
			<!-- Egreso -->
			<xsl:when test="type = 20">
				<TenderControlTransaction>
					<xsl:attribute name="Version">
						<xsl:value-of select="$version" />
					</xsl:attribute>
					<TypeCode>
						<xsl:value-of select="type/@name" />
					</TypeCode>
					<TenderDeposit>
						<SafeID>
							<xsl:value-of select="safe/code" />
						</SafeID>
						<ExternalDepositoryID>
							<xsl:value-of select="depository/code" />
						</ExternalDepositoryID>
						<xsl:call-template name="ProcesarTenderControlTransactionItems" />
					</TenderDeposit>
					<xsl:call-template name="ProcesarApprovals" />
				</TenderControlTransaction>
			</xsl:when>
			<!-- Ingreso -->
			<xsl:when test="type = 21">
				<TenderControlTransaction>
					<xsl:attribute name="Version">
						<xsl:value-of select="$version" />
					</xsl:attribute>
					<TypeCode>
						<xsl:value-of select="type/@name" />
					</TypeCode>
					<TenderReceipt>
						<SafeID>
							<xsl:value-of select="safe/code" />
						</SafeID>
						<ExternalDepositoryID>
							<xsl:value-of select="depository/code" />
						</ExternalDepositoryID>
						<xsl:call-template name="ProcesarTenderControlTransactionItems" />
					</TenderReceipt>
					<xsl:call-template name="ProcesarApprovals" />
				</TenderControlTransaction>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="ProcesarTenderControlTransactionItems">
		<xsl:for-each select="payments/paymentTransaction">
			<TenderControlTransactionTenderLineItem>
				<xsl:if test="voiding=$vTrue">
					<xsl:attribute name="VoidFlag">true</xsl:attribute>
				</xsl:if>
				<SequenceNumber>
					<xsl:value-of select="trxHelper:newTenderControlTenderTrxLineItemNumber()" />
				</SequenceNumber>
				<TenderTypeCode>
					<xsl:value-of select="tender/tender/tenderTypeCode" />
				</TenderTypeCode>
				<Amount>
					<xsl:value-of select="trxHelper:scale(amount)" />
				</Amount>
			</TenderControlTransactionTenderLineItem>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="ProcesarTenderCorrectionTransaction">
		<xsl:for-each select="payments/paymentTransaction">
			<Tender>
				<xsl:if test="additionalData/entry[string='returnFlag']/boolean = $vTrue">
					<xsl:attribute name="TypeCode">Refund</xsl:attribute>
				</xsl:if>
				<xsl:if
					test="additionalData/entry[string='returnFlag']/boolean = $vFalse">
					<xsl:attribute name="TypeCode">Sale</xsl:attribute>
				</xsl:if>
				<TenderID>
					<xsl:value-of select="tender/tender/tenderTypeCode" />
				</TenderID>
				<Amount>
					<xsl:value-of select="trxHelper:scale(amount)" />
				</Amount>
				<xsl:call-template name="ProcesarTipoPago" />
			</Tender>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="ProcesarSaleReturnItems">
		<xsl:for-each select="/ticket/items/itemTicket">
			<xsl:value-of select="trxHelper:resetItemCounters()" />
			<LineItem>
				<xsl:attribute name="EntryMethod">
					<xsl:value-of select="entryMethodCode" />
				</xsl:attribute>
				<xsl:if test="voiding=$vTrue">
					<xsl:attribute name="VoidFlag">true</xsl:attribute>
				</xsl:if>
				<SequenceNumber>
					<xsl:value-of select="trxHelper:newLineItemNumber()" />
				</SequenceNumber>
				<xsl:choose>
					<xsl:when test="isReturned=$vFalse">
						<Sale>
							<xsl:call-template name="ProcesarItems" />
						</Sale>
					</xsl:when>
					<xsl:when test="isReturned=$vTrue">
						<Return>
							<xsl:call-template name="ProcesarItems" />
							<ReturnReasonCode>
								<xsl:value-of select="returnReasonCode" />
							</ReturnReasonCode>
						</Return>
					</xsl:when>
				</xsl:choose>
				<!-- tipo de asociación de los items del tipo garantías *** -->
				<xsl:if test="not(not(operationTypeCode))">
					<Association>
						<xsl:attribute name="TypeCode">
							<xsl:value-of select="operationTypeCode" />
						</xsl:attribute>
						<SequenceNumber>
							<xsl:value-of select="relatedLineItem" />
						</SequenceNumber>
						<PolicyNumber>
							<xsl:value-of select="policyNumber" />
						</PolicyNumber>
						<SerialNumber>
							<xsl:value-of select="itemSerialNumber" />
						</SerialNumber>
					</Association>
				</xsl:if>

				<xsl:if
					test="key('item', trxHelper:getNotNull(item/@reference, item/@id))/internalCode='PaymentOnAccount'">
					<PaymentOnAccount>
						<AccountCardNumber>
							<xsl:value-of select="customerCreditCardAccount" />
						</AccountCardNumber>
						<AccountNumber>
							<xsl:value-of select="customerCreditAccount" />
						</AccountNumber>
						<Amount>
							<xsl:value-of select="trxHelper:scale(actualUnitPrice)" />
						</Amount>
					</PaymentOnAccount>
				</xsl:if>

				<xsl:call-template name="ProcesarAuthorizations" />
			</LineItem>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="ProcesarPaymentCreditAccountItems">
		<xsl:for-each select="/ticket/items/itemTicket">
			<xsl:value-of select="trxHelper:resetItemCounters()" />
			<LineItem>
				<SequenceNumber>
					<xsl:value-of select="trxHelper:newLineItemNumber()" />
				</SequenceNumber>
				<PaymentOnAccount>
					<AccountCardNumber>
						<xsl:value-of select="customerCreditCardAccount" />
					</AccountCardNumber>
					<AccountNumber>
						<xsl:value-of select="customerCreditAccount" />
					</AccountNumber>
					<Amount>
						<xsl:value-of select="trxHelper:scale(actualUnitPrice)" />
					</Amount>
				</PaymentOnAccount>
				<xsl:call-template name="ProcesarAuthorizations" />
			</LineItem>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="ProcesarMonederoLine">
		<xsl:for-each select="/ticket/giftCardTransaction">
			<xsl:value-of select="trxHelper:resetItemCounters()" />
			<LineItem>
				<SequenceNumber>
					<xsl:value-of select="trxHelper:newLineItemNumber()" />
				</SequenceNumber>

				<GiftCertificateID>
					<xsl:value-of select="additionalData/entry[string='cardtype']/string[2]" />
				</GiftCertificateID>
				<CardNumber>
					<xsl:value-of
						select="trxHelper:maskAccountNumber(additionalData/entry[string='account']/string[2])" />
				</CardNumber>
				<PlanID>
					<xsl:value-of select="additionalData/entry[string='planId']/string[2]" />
				</PlanID>
				<CurrencyCode>
					<xsl:value-of
						select="trxHelper:additionalData/entry[string='currencyCode']/string[2]" />
				</CurrencyCode>
				<AuthorizationType>
					<xsl:value-of
						select="trxHelper:additionalData/entry[string='authorization_type']/string[2]" />
				</AuthorizationType>
				<xsl:call-template name="ProcesarAuthorizations" />
			</LineItem>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="ProcesarItems">
		<ItemID>
			<xsl:value-of
				select="key('item', trxHelper:getNotNull(item/@reference, item/@id))/internalCode" />
		</ItemID>
		<POSItemID>
			<xsl:value-of
				select="key('item', trxHelper:getNotNull(item/@reference, item/@id))/barcode/barcode" />
		</POSItemID>
		<Associate>
			<AssociateID>
				<xsl:value-of select="sellerID" />
			</AssociateID>
		</Associate>
		<ItemType>
			<xsl:value-of
				select="trxHelper:cut(key('item', trxHelper:getNotNull(item/@reference, item/@id))/itemType/code,4)" />
		</ItemType>
		<SerialNumber>
			<xsl:value-of select="itemSerialNumber" />
		</SerialNumber>

		<MerchandiseHierarchy>
			<xsl:value-of select="merchandiseHierarchy" />
		</MerchandiseHierarchy>

		<Quantity>
			<xsl:attribute name="Units">
				<xsl:value-of select="units" />
			</xsl:attribute>
			<xsl:attribute name="UnitOfMeasureCode">
				<xsl:value-of select="unitOfMeasureCode" />
			</xsl:attribute>
			<xsl:value-of select="quantity" />
		</Quantity>
		<RegularSaleUnitPrice>
			<xsl:value-of select="trxHelper:scale(regularUnitPrice)" />
		</RegularSaleUnitPrice>
		<ActualUnitPrice>
			<xsl:value-of select="trxHelper:scale(actualUnitPrice)" />
		</ActualUnitPrice>
		<ExtendedAmount>
			<xsl:value-of select="trxHelper:scale(extendedPrice)" />
		</ExtendedAmount>
		<IDLocation>
			<xsl:value-of select="item/location/code" />
		</IDLocation>
		<RetailTransactionDiscount>
			<Amount>
				<xsl:value-of
					select="trxHelper:scale(trxHelper:sumaAbs(trxHelper:sumaAbs(discountAmntTotal,discountPerTotal),discountPromoTotal))" />
			</Amount>
			<Percent>
				<xsl:value-of
					select="trxHelper:scale(trxHelper:getPorcentaje(originalExtendedPrice,discountAmntTotal,discountPerTotal,discountPromoTotal))" />
			</Percent>
		</RetailTransactionDiscount>

		<xsl:call-template name="PriceModifiers" />
		<xsl:call-template name="LineItemTaxs" />

		<xsl:if test="reserved = $vTrue">
			<Reserved>
				<xsl:value-of select="reserved" />
			</Reserved>
			<InventoryReservationID>
				<xsl:value-of select="inventoryReservationID" />
			</InventoryReservationID>
			<StoreReservationID>
				<xsl:value-of select="storeReservationID" />
			</StoreReservationID>
		</xsl:if>
	</xsl:template>

	<xsl:template name="ProcesarAuthorizations">
		<xsl:value-of select="trxHelper:resetApprovalLineItemCounter()" />
		<xsl:for-each select="operationApproval">
			<OperatorBypassApproval>
				<SequenceNumber>
					<xsl:value-of select="trxHelper:newApprovalLineItem()" />
				</SequenceNumber>
				<ApproverID>
					<xsl:value-of
						select="key('operationApproval', trxHelper:getNotNull(@reference, @id))/approver/name" />
				</ApproverID>
				<Description>
					<xsl:value-of
						select="key('operationApproval', trxHelper:getNotNull(@reference, @id))/operation" />
				</Description>
				<EntryMethod>KYD</EntryMethod><!-- TODO: modificar esto, se hardcodea 
					porque es el único método que se admite por ahora -->
				<LineApprovalCode></LineApprovalCode><!-- por ahora va vacío -->
			</OperatorBypassApproval>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="PriceModifiers">
		<xsl:for-each select="priceModifiers/priceModifier">
			<xsl:call-template name="makeRetailPriceModifier">
				<xsl:with-param name="isPromotion">
					<xsl:value-of select="$vFalse" />
				</xsl:with-param>
			</xsl:call-template>
		</xsl:for-each>
		<xsl:for-each select="priceModifiers/promotionPriceModifier">
			<xsl:call-template name="makeRetailPriceModifier">
				<xsl:with-param name="isPromotion">
					<xsl:value-of select="$vTrue" />
				</xsl:with-param>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="makeRetailPriceModifier">
		<xsl:param name="isPromotion" />

		<RetailPriceModifier>
			<xsl:attribute name="MethodCode">
				<xsl:value-of select="methodCode" />
			</xsl:attribute>
			<SequenceNumber>
				<xsl:value-of select="trxHelper:newItemRetailPriceModifierNumber()" />
			</SequenceNumber>
			<Amount>
				<xsl:attribute name="Action">
					<xsl:value-of select="action" />
				</xsl:attribute>
				<xsl:value-of select="trxHelper:scale(amount)" />
			</Amount>
			<xsl:if test="type='PER'">
				<Percent>
					<xsl:value-of select="trxHelper:scale(percent)" />
				</Percent>
			</xsl:if>
			<ReasonCode>
				<xsl:value-of select="reason" />
			</ReasonCode>
			<!-- xsl:if test="$isPromotion=$vTrue"> <PromotionID> <xsl:value-of select="promotionID" 
				/> </PromotionID> </xsl:if -->
			<PromotionID>
				<xsl:value-of select="promotionNumber" />
			</PromotionID>
			<BenefitID>
				<xsl:value-of select="benefitNumber" />
			</BenefitID>
		</RetailPriceModifier>
	</xsl:template>

	<xsl:template name="LineItemTaxs">
		<xsl:for-each select="taxDetail">
			<Tax>
				<xsl:attribute name="TaxType">
					<xsl:value-of select="taxType" />
				</xsl:attribute>
				<xsl:attribute name="TypeCode">
					<xsl:value-of select="typeCode" />
				</xsl:attribute>
				<SequenceNumber>
					<xsl:value-of select="trxHelper:newItemTaxNumber()" />
				</SequenceNumber>
				<TaxAuthority>
					<xsl:value-of select="taxAuthority" />
				</TaxAuthority>
				<Amount>
					<xsl:value-of select="trxHelper:scale(amount)" />
				</Amount>
				<xsl:if test="not(not(taxableAmount))">
					<TaxableAmount>
						<xsl:attribute name="TaxIncludedInTaxableAmountFlag">
							<xsl:value-of select="normalize-space(taxIncludedInTaxableAmountFlag)" />
						</xsl:attribute>
						<xsl:value-of select="trxHelper:scale(taxableAmount)" />
					</TaxableAmount>
				</xsl:if>
				<xsl:if test="not(not(taxablePercentage))">
					<Percent>
						<xsl:value-of select="trxHelper:scale(taxablePercentage)" />
					</Percent>
				</xsl:if>
			</Tax>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="ProcesarApprovals">
		<xsl:value-of select="trxHelper:resetApprovalLineItemCounter()" />
		<xsl:for-each select="operationApproval">
			<OperatorBypassApproval>
				<SequenceNumber>
					<xsl:value-of select="trxHelper:newApprovalLineItem()" />
				</SequenceNumber>
				<ApproverID>
					<xsl:value-of
						select="key('operationApproval', trxHelper:getNotNull(@reference, @id))/approver/name" />
				</ApproverID>
				<Description>
					<xsl:value-of
						select="key('operationApproval', trxHelper:getNotNull(@reference, @id))/operation" />
				</Description>
				<EntryMethod>KYD</EntryMethod><!-- TODO: modificar esto, se hardcodea 
					porque es el único método que se admite por ahora -->
				<LineApprovalCode></LineApprovalCode><!-- por ahora va vacío -->
			</OperatorBypassApproval>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="ProcesarDescuentos">
		<xsl:variable name="transactionType" select="/ticket/transactionType" />
		<xsl:for-each select="/ticket/discounts/discount">
			<LineItem>
				<xsl:if test="voiding=$vTrue">
					<xsl:attribute name="VoidFlag">true</xsl:attribute>
				</xsl:if>
				<SequenceNumber>
					<xsl:value-of select="trxHelper:newLineItemNumber()" />
				</SequenceNumber>
				<Discount>
					<xsl:if test="$transactionType=$returnType">
						<xsl:attribute name="CancelFlag">true</xsl:attribute>
					</xsl:if>
					<xsl:attribute name="ProratedFlag" />
					<xsl:attribute name="TypeCode">
						<xsl:value-of select="type/@name" />
					</xsl:attribute>
					<Amount>
						<xsl:value-of select="trxHelper:scale(discount)" />
					</Amount>
					<xsl:if test="not(not(percent))">
						<Percentage>
							<xsl:value-of select="percent" />
						</Percentage>
					</xsl:if>
					<ReasonCode>
						<xsl:value-of select="reasonCode" />
					</ReasonCode>
				</Discount>
			</LineItem>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="ProcesarPagos">
		<xsl:for-each select="/ticket/payments/paymentTransaction">
			<LineItem>
				<SequenceNumber>
					<xsl:value-of select="trxHelper:newLineItemNumber()" />
				</SequenceNumber>
				<Tender>
					<xsl:attribute name="TenderType">
						<xsl:value-of select="trxHelper:cut(tender/tender/tenderTypeCode,4)" />
					</xsl:attribute>
					<xsl:attribute name="TypeCode">
						<xsl:choose>
							<xsl:when test="trxHelper:moreOrEqualThanZero(/ticket/total)">
								<xsl:choose>
									<xsl:when test="voiding=$vFalse">
										<xsl:value-of select="'Sale'" />
									</xsl:when>
									<xsl:when test="voiding=$vTrue">
										<xsl:value-of select="'Return'" />
									</xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:when test="trxHelper:lessThanZero(/ticket/total)">
								<xsl:choose>
									<xsl:when test="voiding=$vFalse">
										<xsl:value-of select="'Return'" />
									</xsl:when>
									<xsl:when test="voiding=$vTrue">
										<xsl:value-of select="'Sale'" />
									</xsl:when>
								</xsl:choose>
							</xsl:when>
						</xsl:choose>
					</xsl:attribute>
					<Amount>
						<xsl:value-of select="trxHelper:scale(amount)" />
					</Amount>
					<xsl:if test="not(not(foreignAmount))">
						<ForeignCurrencyAmount>
							<xsl:value-of select="trxHelper:scale(foreignAmount)" />
						</ForeignCurrencyAmount>
					</xsl:if>
					<xsl:if
						test="not(not(additionalData/entry[string='customerDocument']/string[2]))">
						<CustomerIDNumber>
							<xsl:value-of
								select="additionalData/entry[string='customerDocument']/string[2]" />
						</CustomerIDNumber>
					</xsl:if>
					<xsl:call-template name="ProcesarTipoPago" />
					<xsl:call-template name="ProcesarAsociacionesPago" />
				</Tender>
			</LineItem>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="ProcesarTipoPago">
		<xsl:if test="tender/tender/tenderTypeCode='Chck'">
			<EntryMethod>
				<xsl:value-of select="additionalData/entry[string='inputType']/string[2]" />
			</EntryMethod>
			<Bankcode>
				<xsl:value-of select="additionalData/entry[string='bankcode']/string[2]" />
			</Bankcode>
			<CheckNumber>
				<xsl:value-of select="additionalData/entry[string='checkNumber']/string[2]" />
			</CheckNumber>
			<CheckEmissionDate>
				<xsl:value-of
					select="additionalData/entry[string='checkEmissionDate']/date" />
			</CheckEmissionDate>
			<Account>
				<xsl:value-of select="additionalData/entry[string='account']/string[2]" />
			</Account>
		</xsl:if>
		<xsl:if test="tender/tender/type/descriptor='Card'">
			<EntryMethod>
				<xsl:value-of select="additionalData/entry[string='inputType']/string[2]" />
			</EntryMethod>
			<Authorization HostAuthorized="true" ForceOnline="true"
				ElectronicSignature="true">
				<RequestedAmount>
					<xsl:value-of select="trxHelper:scale(amount)" />
				</RequestedAmount>
				<AuthorizationCode>
					<xsl:value-of
						select="additionalData/entry[string='authorization_code']/vtolCode/authorizationCode" />
				</AuthorizationCode>
				<ReferenceNumber>
					<xsl:value-of
						select="additionalData/entry[string='authorization_code']/vtolCode/referenceNumber" />
				</ReferenceNumber>
				<MerchantNumber>
					<xsl:value-of
						select="additionalData/entry[string='authorization_code']/vtolCode/store" />
				</MerchantNumber>
				<ProviderID>
					<xsl:value-of
						select="additionalData/entry[string='authorization_code']/vtolCode/host" />
				</ProviderID>
				<AuthorizationDateTime>
					<xsl:value-of
						select="additionalData/entry[string='authorization_code']/vtolCode/datetime" />
				</AuthorizationDateTime>
				<AuthorizingTermID>
					<xsl:value-of
						select="additionalData/entry[string='authorization_code']/vtolCode/node" />
				</AuthorizingTermID>
			</Authorization>

			<xsl:if
				test="additionalData/entry[string='cardtype']/string[2]!='GiftCard'">
				<CreditDebit>
					<xsl:attribute name="CardType">
						<xsl:value-of select="additionalData/entry[string='cardtype']/string[2]" />
					</xsl:attribute>
					<PrimaryAccountNumber>
						<xsl:value-of
							select="trxHelper:maskAccountNumber(additionalData/entry[string='account']/string[2])" />
					</PrimaryAccountNumber>
					<PlanID>
						<xsl:value-of select="additionalData/entry[string='planId']/string[2]" />
					</PlanID>
					<NumberOfInstallments>
						<xsl:value-of select="additionalData/entry[string='installments']/int[1]" />
					</NumberOfInstallments>
				</CreditDebit>
			</xsl:if>

			<xsl:if
				test="not(not(additionalData/entry[string='cardtype']/string[2]='GiftCard'))">
				<GiftCertificateID>
					<xsl:value-of select="additionalData/entry[string='cardtype']/string[2]" />
				</GiftCertificateID>
				<cardNumber>
					<xsl:value-of
						select="trxHelper:maskAccountNumber(additionalData/entry[string='account']/string[2])" />
				</cardNumber>
				<PlanID>
					<xsl:value-of select="additionalData/entry[string='planId']/string[2]" />
				</PlanID>
				<CurrencyCode>
					<xsl:value-of
						select="additionalData/entry[string='currencyCode']/string[2]" />
				</CurrencyCode>

			</xsl:if>

			<PaymentCondition>
				<xsl:value-of select="additionalData/entry[string='installments']/int[1]" />
			</PaymentCondition>
		</xsl:if>
		<xsl:if test="tender/tender/tenderTypeCode='Cash'">
		</xsl:if>
		<xsl:if test="tender/tender/tenderTypeCode='NCC'">
			<ERP_NCCNumber>
				<xsl:value-of
					select="additionalData/entry[string='erpNccNumber']/string[2]" />
			</ERP_NCCNumber>
			<BillNumber>
				<xsl:value-of
					select="additionalData/entry[string='nccbillNumber']/string[2]" />
			</BillNumber>
			<NCCBalance>
				<xsl:value-of select="additionalData/entry[string='nccBalance']/string[2]" />
			</NCCBalance>
			<ExpirationDate>
				<xsl:value-of
					select="additionalData/entry[string='nccExpirationDate']/string[2]" />
			</ExpirationDate>
			<AmountOfBill>
				<xsl:value-of
					select="additionalData/entry[string='nccAmountOfBill']/string[2]" />
			</AmountOfBill>
		</xsl:if>
	</xsl:template>

	<xsl:template name="ProcesarAsociacionesPago">
		<xsl:if
			test="additionalData/entry[string='surchargeTerminalTenderItemSeqNumber'] != ''">
			<Association TypeCode="Surcharge">
				<SequenceNumber>
					<xsl:value-of
						select="additionalData/entry[string='surchargeTerminalTenderItemSeqNumber']/int " />
				</SequenceNumber>
			</Association>
		</xsl:if>
		<xsl:if test="additionalData/entry[string='surchargeItemSeqNumber'] != ''">
			<Association TypeCode="Surcharge">
				<SequenceNumber>
					<xsl:value-of
						select="additionalData/entry[string='surchargeItemSeqNumber']/int " />
				</SequenceNumber>
			</Association>
		</xsl:if>
	</xsl:template>

	<xsl:template name="ProcesarVuelto">
		<xsl:if test="trxHelper:moreThanZero(/ticket/change)">
			<LineItem>
				<SequenceNumber>
					<xsl:value-of select="trxHelper:newLineItemNumber()" />
				</SequenceNumber>
				<TenderChange>
					<xsl:attribute name="TenderType">
							<xsl:value-of select="'Cash'" />
						</xsl:attribute>
					<Amount>
						<xsl:value-of select="trxHelper:scale(/ticket/change)" />
					</Amount>
				</TenderChange>
			</LineItem>
		</xsl:if>
	</xsl:template>

	<xsl:template name="ProcesarTotales">
		<xsl:value-of select="trxHelper:resetTotals()" />
		<xsl:value-of select="trxHelper:setTotalGrossPositiveAmount(positiveGross)" />
		<xsl:value-of select="trxHelper:setTotalGrossNegativeAmount(negativeGross)" />
		<xsl:value-of
			select="trxHelper:setTotalTaxAmount(internalTaxesTotal,ivaTotal)" />
		<xsl:value-of
			select="trxHelper:setTotalManualDiscount(discountsItemsTotal,discountsTransactionTotal)" />
		<xsl:value-of
			select="trxHelper:setTotalAutomaticDiscount(promoDiscountTotal, transactionDiscountPromoTotal)" />
		<xsl:value-of select="trxHelper:setTransactionNetAmount(total)" />
		<xsl:value-of select="trxHelper:setTotalPurchaseAmount(purchaseAmount)" />

		<Total TotalType="TransactionGrossPositiveAmount">
			<xsl:attribute name="CancelFlag">
				<xsl:value-of select="trxHelper:getTotalGrossPositiveSignFlag()" />
			</xsl:attribute>
			<xsl:value-of
				select="trxHelper:scale(trxHelper:getTotalGrossPositiveAmount())" />
		</Total>
		<Total TotalType="TransactionGrossNegativeAmount">
			<xsl:attribute name="CancelFlag">
				<xsl:value-of select="trxHelper:getTotalGrossNegativeSignFlag()" />
			</xsl:attribute>
			<xsl:value-of
				select="trxHelper:scale(trxHelper:getTotalGrossNegativeAmount())" />
		</Total>
		<Total TotalType="TransactionTaxAmount">
			<xsl:attribute name="CancelFlag">
				<xsl:value-of select="trxHelper:getTotalTaxSignFlag()" />
			</xsl:attribute>
			<xsl:value-of select="trxHelper:scale(trxHelper:getTotalTaxAmount())" />
		</Total>
		<Total TotalType="TransactionManualDiscount">
			<xsl:attribute name="CancelFlag">
				<xsl:value-of select="trxHelper:getTotalManualDiscountSignFlag()" />
			</xsl:attribute>
			<xsl:value-of select="trxHelper:scale(trxHelper:getTotalManualDiscount())" />
		</Total>
		<Total TotalType="TransactionAutomaticDiscount">
			<xsl:attribute name="CancelFlag">
				<xsl:value-of select="trxHelper:getTotalAutomaticDiscountSignFlag()" />
			</xsl:attribute>
			<xsl:value-of
				select="trxHelper:scale(trxHelper:getTotalAutomaticDiscount())" />
		</Total>
		<!-- sergio -->
		<Total TotalType="TransactionTotalDiscount">
			<xsl:attribute name="CancelFlag">
				<xsl:value-of select="trxHelper:getTotalDiscountSignFlag()" />
			</xsl:attribute>
			<xsl:value-of select="trxHelper:scale(trxHelper:getTotalDiscount())" />
		</Total>
		<Total TotalType="TransactionPercentageDiscount">
			<xsl:attribute name="CancelFlag">
				<xsl:value-of select="trxHelper:getPercentageDiscountSignFlag()" />
			</xsl:attribute>
			<xsl:choose>
<!-- 				<xsl:when test="type/@name='Return'"> -->
<!-- 					<xsl:value-of -->
<!-- 						select="trxHelper:scale(trxHelper:getNegativePercentageDiscount())" /> -->
<!-- 				</xsl:when> -->
				<xsl:when test="type/@name!='Return'">
					<xsl:value-of
						select="trxHelper:scale(trxHelper:getPositivePercentageDiscount())" />
				</xsl:when>
			</xsl:choose>
		</Total>
		<Total TotalType="TransactionNetAmount">
			<xsl:attribute name="CancelFlag">
				<xsl:value-of select="trxHelper:getTotalNetAmountSignFlag()" />
			</xsl:attribute>
			<xsl:value-of select="trxHelper:scale(trxHelper:getTotalNetAmount())" />
		</Total>
		<Total TotalType="TransactionGrossAmount">
			<xsl:attribute name="CancelFlag">
				<xsl:value-of select="trxHelper:getTotalGrossAmountSignFlag()" />
			</xsl:attribute>
			<xsl:value-of select="trxHelper:scale(trxHelper:getTotalGrossAmount())" />
		</Total>
		<Total TotalType="TransactionPurchaseAmount">
			<xsl:attribute name="CancelFlag">
				<xsl:value-of select="trxHelper:getTotalPurchaseAmountSignFlag()" />
			</xsl:attribute>
			<xsl:value-of select="trxHelper:scale(purchaseAmount)" />
		</Total>
	</xsl:template>

	<xsl:template match="customer">
		<!-- El nombre del cliente -->
		<LineItem>
			<SequenceNumber>
				<xsl:value-of select="trxHelper:newLineItemNumber()" />
			</SequenceNumber>
			<CustomerInformation>
				<xsl:attribute name="TypeCode">
					<xsl:value-of select="'NA'" />
				</xsl:attribute>
				<LineModifier>
					<SequenceNumber>
						<xsl:value-of select="'1'" />
					</SequenceNumber>
					<Id>RegistrationName</Id>
					<Value>
						<xsl:choose>
							<xsl:when test="trxHelper:isPartyAPerson(party/typeCode)">
								<xsl:value-of select="concat(party/lastName, ', ', party/firstName)" />
							</xsl:when>
							<xsl:when test="trxHelper:isPartyAnOrganization(party/typeCode)">
								<xsl:value-of select="party/name" />
							</xsl:when>
						</xsl:choose>
					</Value>
					<FormatCode>
						<xsl:value-of select="'TX'" />
					</FormatCode>
				</LineModifier>
			</CustomerInformation>
		</LineItem>
		<!-- Customer store -->
		<LineItem>
			<SequenceNumber>
				<xsl:value-of select="trxHelper:newLineItemNumber()" />
			</SequenceNumber>
			<CustomerInformation>
				<xsl:attribute name="TypeCode">
					<xsl:value-of select="'NA'" />
				</xsl:attribute>
				<LineModifier>
					<SequenceNumber>
						<xsl:value-of select="'1'" />
					</SequenceNumber>
					<Id>CustomerStore</Id>
					<Value>
						<xsl:value-of select="store/code" />
					</Value>
					<FormatCode>
						<xsl:value-of select="'TX'" />
					</FormatCode>
				</LineModifier>
			</CustomerInformation>
		</LineItem>
		<!-- Party Type -->
		<LineItem>
			<SequenceNumber>
				<xsl:value-of select="trxHelper:newLineItemNumber()" />
			</SequenceNumber>
			<CustomerInformation>
				<xsl:attribute name="TypeCode">
					<xsl:value-of select="'NA'" />
				</xsl:attribute>
				<LineModifier>
					<SequenceNumber>
						<xsl:value-of select="'1'" />
					</SequenceNumber>
					<Id>PartyTypeCode</Id>
					<Value>
						<xsl:choose>
							<xsl:when test="trxHelper:isPartyAPerson(party/typeCode)">
								F
							</xsl:when>
							<xsl:when test="trxHelper:isPartyAnOrganization(party/typeCode)">
								J
							</xsl:when>
						</xsl:choose>
					</Value>
					<FormatCode>
						<xsl:value-of select="'TX'" />
					</FormatCode>
				</LineModifier>
			</CustomerInformation>
		</LineItem>

		<!-- El documento/CUIT del cliente -->
		<LineItem>
			<SequenceNumber>
				<xsl:value-of select="trxHelper:newLineItemNumber()" />
			</SequenceNumber>
			<CustomerInformation>
				<xsl:attribute name="TypeCode">
					<xsl:value-of select="'FI'" />
				</xsl:attribute>
				<LineModifier>
					<SequenceNumber>
						<xsl:value-of select="'1'" />
					</SequenceNumber>
					<Id>RegistrationNumber</Id>
					<Value>
						<xsl:choose>
							<!-- TODO [LEO]: Revisar el seteo de la identificación -->
							<xsl:when test="trxHelper:isPartyAPerson(party/typeCode)">
								<xsl:value-of
									select="party/identifications/partyIdentification/identifier" />
							</xsl:when>
							<xsl:when test="trxHelper:isPartyAnOrganization(party/typeCode)">
								<xsl:value-of
									select="party/identifications/partyIdentification/identifier" />
							</xsl:when>
						</xsl:choose>
					</Value>
					<FormatCode>
						<xsl:value-of select="'TX'" />
					</FormatCode>
				</LineModifier>
			</CustomerInformation>
		</LineItem>

		<!-- Las direcciones del cliente -->
		<xsl:for-each
			select="party/roleAssignments/partyRoleAssignment[1]/contactMethods/partyContactMethod">
			<xsl:apply-templates select="address" />
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="address">
		<LineItem>
			<SequenceNumber>
				<xsl:value-of select="trxHelper:newLineItemNumber()" />
			</SequenceNumber>
			<CustomerInformation>
				<xsl:attribute name="TypeCode">
					<xsl:value-of select="'AD'" />
				</xsl:attribute>
				<!-- Calle y Nro -->
				<LineModifier>
					<SequenceNumber>
						<xsl:value-of select="1" />
					</SequenceNumber>
					<Id>CALLE</Id>
					<Value>
						<xsl:value-of
							select="trxHelper:concat(true(), firstLine, secondLine, thirdLine, fourthLine)" />
					</Value>
					<FormatCode>
						<xsl:value-of select="'TX'" />
					</FormatCode>
				</LineModifier>
				<!-- Ciudad -->
				<LineModifier>
					<SequenceNumber>
						<xsl:value-of select="2" />
					</SequenceNumber>
					<Id>CIUDAD</Id>
					<Value>
						<xsl:value-of select="city/name" />
					</Value>
					<FormatCode>
						<xsl:value-of select="'TX'" />
					</FormatCode>
				</LineModifier>
				<!-- Estado/Provincia -->
				<LineModifier>
					<SequenceNumber>
						<xsl:value-of select="3" />
					</SequenceNumber>
					<Id>PROVINCIA</Id>
					<Value>
						<xsl:value-of
							select="key('state', trxHelper:getNotNull(state/@reference, state/@id))/name" />
					</Value>
					<FormatCode>
						<xsl:value-of select="'TX'" />
					</FormatCode>
				</LineModifier>
				<!-- Código Postal -->
				<LineModifier>
					<SequenceNumber>
						<xsl:value-of select="4" />
					</SequenceNumber>
					<Id>CODIGO POSTAL</Id>
					<Value>
						<xsl:value-of select="postalCode" />
					</Value>
					<FormatCode>
						<xsl:value-of select="'TX'" />
					</FormatCode>
				</LineModifier>
				<!-- País -->
				<LineModifier>
					<SequenceNumber>
						<xsl:value-of select="5" />
					</SequenceNumber>
					<Id>PAIS</Id>
					<Value>
						<xsl:value-of
							select="key('country', trxHelper:getNotNull(country/@reference, country/@id))/name" />
					</Value>
					<FormatCode>
						<xsl:value-of select="'TX'" />
					</FormatCode>
				</LineModifier>
			</CustomerInformation>
		</LineItem>
	</xsl:template>

	<xsl:template match="/customerOrderControl" name="CustomerOrderControlTransaction">
		<PosLog>
			<Transaction>
				<xsl:call-template name="ProcesarTransactionHeader" />
				<CustomerOrderControlTransaction>
					<xsl:attribute name="Version">
					<xsl:value-of select="$version" />
				</xsl:attribute>
					<TypeCode>
						<xsl:value-of select="type/@name" />
					</TypeCode>
					<CurrencyCode>
						<xsl:value-of select="currencyCode" />
					</CurrencyCode>
					<Recovered>
						<xsl:value-of select="recovered" />
					</Recovered>

					<CustomerOrderVersion>
						<xsl:value-of select="customerOrderVersion" />
					</CustomerOrderVersion>

					<CustomerOrderStateCode>
						<xsl:value-of select="customerOrderStateCode" />
					</CustomerOrderStateCode>
					<CustomerOrderTypeCode>
						<xsl:value-of select="customerOrderTypeCode" />
					</CustomerOrderTypeCode>

					<Address>
						<xsl:value-of select="address" />
					</Address>
					<ContactPerson>
						<xsl:attribute name="Id">
						<xsl:value-of select="customer/id" />
					</xsl:attribute>
						<xsl:attribute name="Code">
						<xsl:value-of select="customer/code" />
					</xsl:attribute>
						<xsl:value-of select="contactPerson" />
					</ContactPerson>
					<AdditionalDeliveryData>
						<xsl:value-of select="AdditionalDeliveryData" />
					</AdditionalDeliveryData>
					<ShipmentPrice>
						<xsl:value-of select="shipmentPrice" />
					</ShipmentPrice>
					<DeliveryShift>
						<xsl:value-of select="deliveryShift" />
					</DeliveryShift>
					<BaseCurrency>
						<xsl:value-of select="baseCurrency" />
					</BaseCurrency>
					<CreationDate>
						<xsl:value-of select="creationDate" />
					</CreationDate>
					<UpdateDate>
						<xsl:value-of select="updateDate" />
					</UpdateDate>
					<EstimatedAvailabilityDate>
						<xsl:value-of select="estimatedAvailabilityDate" />
					</EstimatedAvailabilityDate>
					<RetirementStoreCode>
						<xsl:value-of select="retirementStoreCode" />
					</RetirementStoreCode>

					<xsl:call-template
						name="ProcesarCustomerOrderControlTransactionLineItems" />

					<xsl:call-template name="ProcesarDescuentos" />

					<xsl:call-template name="ProcesarCustomerOrderPaymentLineItems" />

					<xsl:apply-templates select="customer" />

					<xsl:call-template name="ProcesarTotales" />
					<Total TotalType="CustomerOrderTotal">
						<xsl:value-of select="trxHelper:scale(total)" />
					</Total>

					<xsl:call-template name="ProcesarApprovals" />

					<RingElapsedTime>
						<xsl:value-of select="ringElapsedTime" />
					</RingElapsedTime>

					<TenderElapsedTime>
						<xsl:value-of select="tenderElapsedTime" />
					</TenderElapsedTime>

					<LockElapsedTime>
						<xsl:value-of select="lockTime" />
					</LockElapsedTime>

				</CustomerOrderControlTransaction>
			</Transaction>
			<xsl:call-template name="ProcesarEJ" />
			<xsl:call-template name="ProcesarAudit" />
		</PosLog>
	</xsl:template>

	<xsl:template name="ProcesarCustomerOrderControlTransactionLineItems">
		<xsl:for-each
			select="/customerOrderControl/customerOrderControlTransactionLineItems/lineItem">
			<xsl:value-of select="trxHelper:resetItemCounters()" />
			<LineItem>
				<xsl:attribute name="EntryMethod">
					<xsl:value-of select="entryMethodCode" />
				</xsl:attribute>
				<xsl:if test="voiding=$vTrue">
					<xsl:attribute name="VoidFlag">true</xsl:attribute>
				</xsl:if>
				<SequenceNumber>
					<xsl:value-of select="trxHelper:newLineItemNumber()" />
				</SequenceNumber>
				<xsl:choose>
					<xsl:when test="isReturned=$vFalse">
						<Sale>
							<xsl:call-template name="ProcesarItems" />
						</Sale>
					</xsl:when>
					<xsl:when test="isReturned=$vTrue">
						<Return>
							<xsl:call-template name="ProcesarItems" />
						</Return>
					</xsl:when>
				</xsl:choose>
				<xsl:call-template name="ProcesarAuthorizations" />
			</LineItem>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="ProcesarCustomerOrderPaymentLineItems">
		<xsl:for-each select="/customerOrderControl/payments/paymentTransaction">
			<LineItem>
				<SequenceNumber>
					<xsl:value-of select="trxHelper:newLineItemNumber()" />
				</SequenceNumber>
				<Tender>
					<xsl:attribute name="TenderType">
						<xsl:value-of select="trxHelper:cut(tender/tender/tenderTypeCode,4)" />
					</xsl:attribute>
					<xsl:attribute name="TypeCode">
						<xsl:choose>
							<xsl:when
						test="trxHelper:moreOrEqualThanZero(/customerOrderControl/total)">
								<xsl:choose>
									<xsl:when test="voiding=$vFalse">
										<xsl:value-of select="'Sale'" />
									</xsl:when>
									<xsl:when test="voiding=$vTrue">
										<xsl:value-of select="'Return'" />
									</xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:when test="trxHelper:lessThanZero(/customerOrderControl/total)">
								<xsl:choose>
									<xsl:when test="voiding=$vFalse">
										<xsl:value-of select="'Return'" />
									</xsl:when>
									<xsl:when test="voiding=$vTrue">
										<xsl:value-of select="'Sale'" />
									</xsl:when>
								</xsl:choose>
							</xsl:when>
						</xsl:choose>
					</xsl:attribute>
					<Amount>
						<xsl:value-of select="trxHelper:scale(amount)" />
					</Amount>
					<xsl:if test="not(not(foreignAmount))">
						<ForeignCurrencyAmount>
							<xsl:value-of select="trxHelper:scale(foreignAmount)" />
						</ForeignCurrencyAmount>
					</xsl:if>
					<xsl:if
						test="not(not(additionalData/entry[string='customerDocument']/string[2]))">
						<CustomerIDNumber>
							<xsl:value-of
								select="additionalData/entry[string='customerDocument']/string[2]" />
						</CustomerIDNumber>
					</xsl:if>
					<xsl:call-template name="ProcesarAsociacionesPago" />
				</Tender>
			</LineItem>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="ProcesarEJ">
		<EJ>
			<xsl:for-each
				select="electronicJournal/linesElectronicJournal/electronicJournalData">
				<EJLine>
					<Date>
						<xsl:value-of select="dateStr" />
					</Date>
					<Terminal>
						<xsl:value-of select="terminal" />
					</Terminal>
					<Line>
						<xsl:value-of select="detail" />
					</Line>
				</EJLine>
			</xsl:for-each>
		</EJ>
	</xsl:template>

	<xsl:template name="ProcesarAudit">
		<Audit>
			<xsl:for-each select="audit/auditLines/auditData">
				<AuditLine>
					<Date>
						<xsl:value-of select="dateStr" />
					</Date>
					<Code>
						<xsl:value-of select="code" />
					</Code>
					<User>
						<xsl:value-of select="userId" />
					</User>
					<Description>
						<xsl:value-of select="description" />
					</Description>
					<Detailed>
						<xsl:value-of select="detailed" />
					</Detailed>
					<Line>
						<xsl:value-of select="stackTrace" />
					</Line>
					<Terminal>
						<xsl:value-of select="terminalId" />
					</Terminal>
					<NumberTransaction>
						<xsl:value-of select="transactionId" />
					</NumberTransaction>
					<Process>
						<xsl:value-of select="process" />
					</Process>
					<SubProcess>
						<xsl:value-of select="subProcess" />
					</SubProcess>
				</AuditLine>
			</xsl:for-each>
		</Audit>
	</xsl:template>

	<xsl:template name="ProcesarCustomerTransaction">
		<Transaction>
			<xsl:call-template name="ProcesarTransactionHeader" />
			<ControlTransaction>
				<xsl:attribute name="Version">
					<xsl:value-of select="$version" />
				</xsl:attribute>
				<TypeCode>
					<xsl:value-of select="type/@name" />
				</TypeCode>
				<Customer>
					<CustomerID>
						<xsl:value-of select="newCustomer/code" />
					</CustomerID>
					<CustomerType>
						<xsl:value-of select="newCustomer/party/typeCode" />
					</CustomerType>
					<CustomerName>
						<xsl:choose>
							<xsl:when test="trxHelper:isPartyAPerson(newCustomer/party/typeCode)">
								<FirstName>
									<xsl:value-of select="newCustomer/party/firstName" />
								</FirstName>
								<LastName>
									<xsl:value-of select="newCustomer/party/lastName" />
								</LastName>
							</xsl:when>
							<xsl:when
								test="trxHelper:isPartyAnOrganization(newCustomer/party/typeCode)">
								<OrganizationName>
									<xsl:value-of select="newCustomer/party/name" />
								</OrganizationName>
							</xsl:when>
						</xsl:choose>
					</CustomerName>
					<xsl:for-each
						select="newCustomer/party/roleAssignments/partyRoleAssignment">
						<xsl:for-each select="contactMethods/partyContactMethod">
							<ContactMethod>
								<Address>
									<ContactMethodType>
										<xsl:value-of select="methodType/name" />
									</ContactMethodType>
									<AddressLineFirst>
										<xsl:value-of select="address/firstLine" />
									</AddressLineFirst>
									<AddressLineSecond>
										<xsl:value-of select="address/secondLine" />
									</AddressLineSecond>
									<AddressLineThird>
										<xsl:value-of select="address/thirdLine" />
									</AddressLineThird>
									<AddressLineFourth>
										<xsl:value-of select="address/fourthLine" />
									</AddressLineFourth>
									<City>
										<xsl:value-of select="address/city/code" />
									</City>
									<Territory>
										<xsl:value-of select="address/city/state/code" />
									</Territory>
									<CountryCode>
										<xsl:value-of select="address/city/state/country/code" />
									</CountryCode>
								</Address>
								<TelephoneNumber>
									<CountryCode>
										<xsl:value-of select="telephone/countryCode" />
									</CountryCode>
									<AreaCode>
										<xsl:value-of select="telephone/areaCode" />
									</AreaCode>
									<TelephoneNumber>
										<xsl:value-of select="telephone/telephoneNumber" />
									</TelephoneNumber>
									<ExtensionNumber>
										<xsl:value-of select="telephone/extensionNumber" />
									</ExtensionNumber>
								</TelephoneNumber>
								<eMail>
									<xsl:value-of select="emailAddress/emailAddress" />
								</eMail>
							</ContactMethod>
						</xsl:for-each>
					</xsl:for-each>
					<xsl:choose>
						<xsl:when test="trxHelper:isPartyAPerson(newCustomer/party/typeCode)">
							<Birthdate>
								<xsl:value-of
									select="concat(concat(newCustomer/party/birthYearNumber,'-'),concat(concat(newCustomer/party/birthMonthNumber,'-'),newCustomer/party/birthDayNumber))" />
							</Birthdate>
							<YearOfBirth>
								<xsl:value-of select="newCustomer/party/birthYearNumber" />
							</YearOfBirth>
							<Gender>
								<xsl:value-of select="newCustomer/party/genderType" />
							</Gender>
						</xsl:when>
					</xsl:choose>
					<xsl:for-each
						select="newCustomer/party/identifications/partyIdentification">
						<PartyIdentificationType>
							<Type>
								<xsl:value-of select="type/id" />
							</Type>
							<Identifier>
								<xsl:value-of select="identifier" />
							</Identifier>
							<IssueDate>
								<xsl:value-of select="issueDate" />
							</IssueDate>
							<ExpirationDate>
								<xsl:value-of select="expirationDate" />
							</ExpirationDate>
						</PartyIdentificationType>
					</xsl:for-each>
					<xsl:for-each select="newCustomer/party/taxRegistrations/taxRegistration">
						<TaxRegistration>
							<RegistrationNumber>
								<xsl:value-of select="number" />
							</RegistrationNumber>
							<xsl:for-each select="taxTypes/taxRegistrationTaxType">
								<xsl:variable name="jurisdictionAndType"
									select="key('jurisdictionAndType', trxHelper:getNotNull(jurisdictionAndType/@reference, jurisdictionAndType/@id))" />
								<TaxRegistrationTaxType>
									<Type>
										<xsl:value-of
											select="key('type', trxHelper:getNotNull($jurisdictionAndType/type/@reference, $jurisdictionAndType/type/@id))/code" />
									</Type>
									<IssueDate>
										<xsl:value-of select="effectiveDate" />
									</IssueDate>
									<ExpirationDate>
										<xsl:value-of select="expirationDate" />
									</ExpirationDate>
									<CustomerTaxTypeCategory>
										<xsl:value-of
											select="key('taxCategory', trxHelper:getNotNull($jurisdictionAndType/taxCategory/@reference, $jurisdictionAndType/taxCategory/@id))/taxCategoryCode" />
									</CustomerTaxTypeCategory>
									<Jurisdiction>
										<xsl:value-of
											select="key('jurisdiction', trxHelper:getNotNull($jurisdictionAndType/jurisdiction/@reference, $jurisdictionAndType/jurisdiction/@id))/taxJurisdictionCode" />
									</Jurisdiction>
									<xsl:for-each select="certificates/taxCertificate">
										<TaxCertificate>
											<SequenceNumber>
												<xsl:value-of select="sequenceNumber" />
											</SequenceNumber>
											<IssueDate>
												<xsl:value-of select="certificateIssueDate" />
											</IssueDate>
											<ExpirationDate>
												<xsl:value-of select="certificateExpirationDate" />
											</ExpirationDate>
											<TaxExemptionPercentage>
												<xsl:value-of select="percentage" />
											</TaxExemptionPercentage>
											<TaxRateClassCode>
												<xsl:value-of select="rateClass/code" />
											</TaxRateClassCode>
										</TaxCertificate>
									</xsl:for-each>
								</TaxRegistrationTaxType>
							</xsl:for-each>
						</TaxRegistration>
					</xsl:for-each>
				</Customer>
				<Action></Action>
			</ControlTransaction>
		</Transaction>
	</xsl:template>

	<xsl:template match="/newCustomer" name="CustomerTransaction">
		<PosLog>
			<xsl:call-template name="ProcesarCustomerTransaction" />
		</PosLog>
	</xsl:template>

</xsl:stylesheet>