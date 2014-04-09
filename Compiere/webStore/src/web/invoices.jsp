<%@ include file="/WEB-INF/jspf/page.jspf" %>
<c:if test='${empty webUser || !webUser.loggedIn}'>
  <c:redirect url='loginServlet?ForwardTo=invoices.jsp'/>
</c:if>
<html>
<!--
  - Author:  Jorg Janke
  - Version: $Id: invoices.jsp,v 1.2 2006/05/06 00:41:33 mdeaelfweald Exp $
  - Compiere ERP & CRM Smart Business Solution - Copyright (c) 1999-2003 Jorg Janke
  - - -
  - Web Store Invoices
  -->
<head>
<%@ include file="/WEB-INF/jspf/head.jspf" %>
<title><c:out value='${ctx.name}'/> - My Invoices</title>
</head>
<body><div id="page">
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<div id="main">
	<%@ include file="/WEB-INF/jspf/menu.jspf" %>
    <%@ include file="/WEB-INF/jspf/vendor.jspf" %>
	<div id="content"> 
	<h2>My Invoices</h2>
	<c:if test='${not empty info.info}'>
	  <p><b><c:out value='${info.message}'/></b></p>
	</c:if>
      <table class="contentTable">
        <tr> 
          <th class="left">Document No</th>
          <th class="left">Description</th>
          <th class="left">Date</th>
          <th class="amount">Total Lines</th>
          <th class="amount">Grand Total</th>
          <th class="right">Invoice</th>
          <th class="right">Open</th>
        </tr>
        <c:forEach items='${info.invoices}' var='invoice' varStatus='status'> 

        	<jsp:useBean id="status" type="javax.servlet.jsp.jstl.core.LoopTagStatus" />
        	<c:choose>
        		<c:when test="<%= status.getCount() %2 == 0 %>">
	        		<c:set var="rowClass" value="evenRow"/>
        		</c:when>
        		<c:otherwise>
	        		<c:set var="rowClass" value="oddRow"/>
        		</c:otherwise>
        	</c:choose>
        <tr> 
          <td class="<c:out value='${rowClass}' /> left"><a href="invoiceLines.jsp?C_Invoice_ID=<c:out value='${invoice.c_Invoice_ID}'/>"><c:out value='${invoice.documentNo}'/></a></td>
          <td class="<c:out value='${rowClass}' /> left"><c:out value='${invoice.description}'/>&nbsp;</td>
          <td class="<c:out value='${rowClass}' /> left"><fmt:formatDate value='${invoice.dateInvoiced}'/></td>
          <td class="<c:out value='${rowClass}' /> amount"><fmt:formatNumber value='${invoice.totalLines}' type="currency" currencySymbol=""/></td>
          <td class="<c:out value='${rowClass}' /> amount"><c:out value='${invoice.currencyISO}'/>&nbsp;<fmt:formatNumber value='${invoice.grandTotal}' type="currency" currencySymbol=""/></td>
          <td class="<c:out value='${rowClass}' />">
           <a href="invoiceServlet/I_<c:out value='${invoice.documentNo}'/>.pdf?Invoice_ID=<c:out value='${invoice.c_Invoice_ID}'/>" target="_blank">
           <img align="right" src="res/pdf.gif" alt="Get Invoice Image" width="30" height="30" border="0"></a>
          </td>
          <td class="<c:out value='${rowClass}' /> right"><c:if test='${invoice.paid}'>Paid</c:if><c:if test='${not invoice.paid}'> 
            <input type="submit" name="InvoicePay" value="Pay <c:out value='${invoice.openAmt}'/>" 
			  onClick="window.top.location.replace('paymentServlet?C_Invoice_ID=<c:out value='${invoice.c_Invoice_ID}'/>&Amt=<c:out value='${invoice.openAmt}'/>');">
            </c:if></td>
        </tr>
        </c:forEach> 
      </table>
      <p>&nbsp;</p></div>
</div>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
</div></body>
</html>