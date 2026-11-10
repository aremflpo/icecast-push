<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:include href="includes/page.xsl"/>
    <xsl:include href="includes/mountnav.xsl"/>
    <xsl:variable name="title">Push Relays</xsl:variable>
    <xsl:template name="content">
        <h2>Push Relays</h2>
        <section class="box">
            <h3 class="box_title">Mountpoint <code><xsl:value-of select="current_source"/></code></h3>
            <xsl:call-template name="mountnav">
                <xsl:with-param name="mount" select="current_source"/>
            </xsl:call-template>
            <xsl:if test="message">
                <p role="status"><xsl:value-of select="message"/></p>
            </xsl:if>
            <xsl:if test="relay">
                <table class="table-block">
                    <thead><tr><th>Protocol</th><th>Destination</th><th>Status</th><th>Action</th></tr></thead>
                    <tbody>
                        <xsl:for-each select="relay">
                            <tr>
                                <td><xsl:choose><xsl:when test="protocol = 'shoutcast'">SHOUTcast v1</xsl:when><xsl:otherwise>Icecast</xsl:otherwise></xsl:choose></td>
                                <td><code><xsl:value-of select="concat(host, ':', port, target)"/></code></td>
                                <td><xsl:value-of select="status"/></td>
                                <td>
                                    <form method="post" action="/admin/pushrelays.xsl?mount={../current_source}">
                                        <input type="hidden" name="relay_token" value="{../relay_token}"/>
                                        <input type="hidden" name="relay_action" value="remove"/>
                                        <input type="hidden" name="protocol" value="{protocol}"/>
                                        <input type="hidden" name="host" value="{host}"/>
                                        <input type="hidden" name="port" value="{port}"/>
                                        <input type="hidden" name="target" value="{target}"/>
                                        <button type="submit">Remove</button>
                                    </form>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
                <p><a href="/admin/pushrelays.xsl?mount={current_source}">Refresh status</a></p>
            </xsl:if>
            <h4>Add destination</h4>
            <p>Destinations added here apply while this source stays connected.</p>
            <form method="post" action="/admin/pushrelays.xsl?mount={current_source}">
                <input type="hidden" name="relay_token" value="{relay_token}"/>
                <input type="hidden" name="relay_action" value="add"/>
                <p><label>Protocol <select name="protocol">
                    <option value="icecast">Icecast</option>
                    <option value="shoutcast">SHOUTcast v1</option>
                </select></label></p>
                <p>For SHOUTcast v1, enter the same port shown in BUTT. The source connection uses that port plus one.</p>
                <p><label>Server <input name="host" required="required" maxlength="253"/></label></p>
                <p><label>Port <input name="port" type="number" value="8000" min="1" max="65535" required="required"/></label></p>
                <p><label>Remote mountpoint (Icecast only) <input name="target" placeholder="/radio" maxlength="1024"/></label></p>
                <p><label>Source username (Icecast only) <input name="username" value="source" maxlength="255"/></label></p>
                <p>For SHOUTcast AutoDJ, enter the DJ credentials as <code>username:password</code> in the password field.</p>
                <p><label>Source password <input name="password" type="password" autocomplete="new-password" required="required" maxlength="767"/></label></p>
                <button type="submit">Add destination</button>
            </form>
        </section>
    </xsl:template>
</xsl:stylesheet>
