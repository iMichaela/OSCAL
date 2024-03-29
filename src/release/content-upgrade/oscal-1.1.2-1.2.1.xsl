<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xpath-default-namespace="http://csrc.nist.gov/ns/oscal/1.0"
xmlns="http://csrc.nist.gov/ns/oscal/1.0"
version="3.0">
<!-- Identity template to copy elements and attributes by default -->
<xsl:template match="@* | node()">
    <xsl:copy>
        <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
</xsl:template>

<!-- Match any complex type with "exports" in the name and reposition it one level up in the tree -->
<xsl:template match="xs:complexType[contains(@name, 'export')]">
    <xsl:copy>
        <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
</xsl:template>

<!-- Prevent duplication of "export" complex types by removing them from their original position -->
<xsl:template match="*[contains(local-name(), 'by-component')]/xs:complexType[contains(@name, 'export')]"/>

<!-- Match any complex type with "shared-responsibility" in the name and update its content -->
<xsl:template match="xs:complexType[contains(@name, 'shared-responsibility')]">
    <xsl:copy>
        <xsl:apply-templates select="@*"/>
        <xs:sequence>
            <xsl:apply-templates select="xs:sequence/*"/>
            <!-- Add new elements specific to shared-responsibility -->
            <xs:element name="source-ssp" type="oscal-responsibility-common-source-ssp-ASSEMBLY" minOccurs="0" maxOccurs="1"/>
            <xs:element name="control-implementation" type="oscal-shared-responsibility-control-implementation-ASSEMBLY" minOccurs="1" maxOccurs="1"/>
        </xs:sequence>
    </xsl:copy>
</xsl:template>

<!-- Match any complex type with "leveraged-authorization" in the name and update its content -->
<xsl:template match="xs:complexType[contains(@name, 'leveraged-authorization')]">
    <xsl:copy>
        <xsl:apply-templates select="@*"/>
        <xs:sequence>
            <xsl:apply-templates select="xs:sequence/*"/>
            <!-- Add new attributes specific to leveraged-authorization -->
            <xs:attribute name="ssp-uuid" type="UUIDDatatype"/>
            <xs:attribute name="sr-uuid" type="UUIDDatatype"/>
        </xs:sequence>
    </xsl:copy>
</xsl:template>

<!-- Match any complex type with "by-component" in the name and update its content -->
<xsl:template match="xs:complexType[contains(@name, 'by-component')]">
    <xsl:copy>
        <xsl:apply-templates select="@*"/>
        <xs:sequence>
            <xsl:apply-templates select="xs:sequence/*"/>
            <!-- Add new elements specific to by-component -->
            <xs:element name="provided" type="oscal-responsibility-common-provided-ASSEMBLY" minOccurs="0" maxOccurs="unbounded"/>
            <xs:element name="responsibility" type="oscal-responsibility-common-responsibility-ASSEMBLY" minOccurs="0" maxOccurs="unbounded"/>
            <xs:element name="inherited" type="oscal-responsibility-common-inherited-ASSEMBLY" minOccurs="0" maxOccurs="unbounded"/>
            <xs:element name="satisfied" type="oscal-responsibility-common-satisfied-ASSEMBLY" minOccurs="0" maxOccurs="unbounded"/>
        </xs:sequence>
    </xsl:copy>
</xsl:template>
</xsl:stylesheet>